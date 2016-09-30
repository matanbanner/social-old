json.extract! user, :id, :name, :email, :country, :birthday, :profile_picture, :cover_photo, :status, :created_at, :updated_at
json.url user_url(user, format: :json)