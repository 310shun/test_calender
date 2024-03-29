class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
    #@todo.due = Date.today + 1.week

    if request.xml_http_request?
      render partial: "form"
    end
  end

  # GET /todos/1/edit
  def edit
    if request.xml_http_request?
      render partial: "form"
    end
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    if request.xml_http_request?
      if @todo.save
        render json: {due: @todo.due.day, task: @todo.task, id: @todo.id}
        #render json: @todo
      end
    else

      respond_to do |format|
        if @todo.save
          format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
          format.json { render action: 'show', status: :created, location: @todo }
        else
          format.html { render action: 'new' }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    if request.xml_http_request?
      
      if params[:due] && @todo.update(due: params[:due], task: params[:task])
        render json: {due: @todo.due.day, task: @todo.task, id: @todo.id}
      elsif todo_params && @todo.update(todo_params)
        render json: {due: @todo.due.day, task: @todo.task, id: @todo.id}
      else      


      # if todo_params && @todo.update(todo_params)
      #   render json: {due: @todo.due.day, task: @todo.task, id: @todo.id}
      # elsif @todo.update(due: params[:due], task: params[:task])
      #   render json: {due: @todo.due.day, task: @todo.task, id: @todo.id}
      # else
        render json: {success: false}
      end
    else
      respond_to do |format|
        if @todo.update(todo_params)
          format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @todo.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    if request.xml_http_request?
      render json: {success: true}
    else
      respond_to do |format|
        format.html { redirect_to todos_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:due, :task, :generate, :scaffold, :calender_todo)
    end
end
