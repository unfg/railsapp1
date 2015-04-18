json.array!(@companies) do |company|
  json.extract! company, :id, :title, :last_file_date, :last_file_name
  json.url company_url(company, format: :json)
end
