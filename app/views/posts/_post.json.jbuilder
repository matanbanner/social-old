json.extract! post, :id, :title, :body, :publisher_id, :shared_id, :created_at, :updated_at
json.url post_url(post, format: :json)