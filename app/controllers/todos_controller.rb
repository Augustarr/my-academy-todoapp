class TodosController < ApplicationController
   before_action :set_todo, only: [ :show, :edit, :update, :destroy ]

  def index
    @todos = Todo.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @todos = Todo.new
    redirect_to root_path
  end

  def create
   @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.turbo_stream
        format.html { redirect_to todo_url(@todo), notice: "Todo was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}_form", partial: "form", locals: { todo: @todo }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@todo)}", partial: "todo", locals: { todo: @todo }) }
        format.html { redirect_to root_path, notice: "Todo updated successfully." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
   @todo.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@todo)}") }
      format.html { redirect_to todos_path, status: :see_other, notice: "Todo was successfully destroyed." }
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :completed)
  end
end
