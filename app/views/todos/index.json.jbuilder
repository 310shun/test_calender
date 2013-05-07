json.array!(@todos) do |todo|
  json.extract! todo, :due, :task, :generate, :scaffold, :calender_todo
  json.url todo_url(todo, format: :json)
end