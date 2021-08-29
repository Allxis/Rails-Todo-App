json.extract! todo, :id, :title, :note, :expiration_date, :done, :created_at, :updated_at
json.url todo_url(todo, format: :json)
