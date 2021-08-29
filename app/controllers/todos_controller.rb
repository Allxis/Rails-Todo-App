class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]
  # user can only edit, update or delete his own tasks, not those of other users
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /todos or /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    #@todo = Todo.new
    @todo = current_user.todos.build
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    #@todo = Todo.new(todo_params)
    @todo = current_user.todos.build(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Aufgabe wurde angepinnt!" }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Änderungen wurden erfolgreich gespeichert!" }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Aufgabe wurde erfolgreich gelöscht!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :note, :expiration_date, :done, :user_id)
    end

  # check if id of the current user matches with the id of the corresponding task
  # if not, send him back to the homepage and leave him a message
  def correct_user
    @todo = current_user.todos.find_by(id: params[:id])
    redirect_to root_path, notice: "Unauthorisierter Zugriff!" if @todo.nil?
  end
end
