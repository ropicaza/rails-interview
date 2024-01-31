module Api
  class TodoListsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      @todo_lists = TodoList.all

      respond_to :json
    end

    def create
      todo_list = TodoList.new(todo_list_params)

      if todo_list.save
        render json: todo_list, status: :created
      else
        render json: todo_list.errors, status: :unprocessable_entity
      end
    end

    def destroy
      todo_list = find_todo_list
      if todo_list.destroy
        head :no_content
      else
        render json: todo_list.errors, status: :unprocessable_entity
      end
    end

    def update
      todo_list = find_todo_list

      todo_list.update(todo_list_params)
    end

    private

    def find_todo_list
      TodoList.find(params[:id])
    end

    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
  end
end
