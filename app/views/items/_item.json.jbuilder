json.extract! item, :id, :done, :associated_date, :summary, :description, :created_at, :updated_at
json.url item_url(item, format: :json)
