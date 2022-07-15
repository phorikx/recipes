json.extract! recipe, :id, :body, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
