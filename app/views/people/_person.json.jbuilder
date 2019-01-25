json.extract! person, :id, :id, :first_name, :last_name, :username, :email, :created_at, :updated_at
json.url person_url(person, format: :json)
