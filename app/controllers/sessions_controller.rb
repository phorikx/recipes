# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.activated?
        create_session user
      else
        handle_unactivated_user
      end
    else
      handle_invalid_login
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

  def create_session(user)
    forwarding_url = session[:forwarding_url]
    reset_session
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    log_in user
    redirect_to forwarding_url || user
  end

  def handle_unactivated_user
    message = 'Account not activated.'
    message += 'Check your email for the activation link'
    flash[:warning] = message
    redirect_to root_url
  end

  def handle_invalid_login
    flash.now[:danger] = 'Invalid email/password combination!' # Not quite right
    render 'new', status: :unprocessable_entity
  end
end
