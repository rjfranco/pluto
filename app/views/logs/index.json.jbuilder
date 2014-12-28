json.array!(@logs) do |log|
  json.extract! log, :id, :time, :date, :remote
  json.url log_url(log, format: :json)
end
