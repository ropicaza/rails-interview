module Api
  class TodoItemsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      @todo_items = TodoItem.where(todo_list_id: params[:todo_list_id])

      respond_to :json
    end

    def create
      todo_item = TodoItem.new(todo_item_params)

      if todo_item.save
        render json: todo_item, status: :created
      else
        render json: todo_item.errors, status: :unprocessable_entity
      end
    end

    def destroy
      todo_item = find_todo_item
      if todo_item.destroy
        head :no_content
      else
        render json: todo_item.errors, status: :unprocessable_entity
      end
    end

    def update
      todo_item = find_todo_item

      todo_item.update(todo_item_params)
    end

    private

    def find_todo_item
      TodoItem.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :description, :complete, :todo_list_id)
    end
  end
end
