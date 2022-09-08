# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'user@realadress.com'
  layout 'mailer'
end
