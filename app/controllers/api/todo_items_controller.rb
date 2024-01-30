module Api
  class TodoItemsController < ApplicationController
    protect_from_forgery with: :null_session

    # GET /api/todolists/id/todoitems
    def index
      @todo_items = TodoItem.where(todo_list_id: params[:todo_list_id])

      respond_to :json
    end

    def create
      TodoItem.create!(todo_item_params)
    end

    private

    def todo_item_params
      params.require(:todo_item).permit(:name, :description, :complete, :todo_list_id)
    end
  end
end
