module TodosHelper
  def get_todo(calender_date)
    todos = Todo.where(due: calender_date)
  end
end
