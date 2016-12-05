json.extract! profile, :id, :name, :city, :info, :created_at, :updated_at
json.url profile_url(profile, format: :json)