class Api::V1::TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_category
    before_action :set_task, only: %i[show edit update destroy]

    def index
        @tasks = @category.tasks.all
        render json: @tasks
    end

    def show

    end

    def new
        @task = @category.tasks.build
    end

    def create
        @task = @category.tasks.build(task_params)

        if @task.save
            render json: @task
        else
            render json: { error: "Failed to create task" }, status: :unprocessable_entity
        end
    end

    def edit
        
    end

    def update
        if @task.update(task_params)
            render json: @task
        else

        end
    end

    def destroy
        @task.destroy
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end

    def set_category
        @category = @user.categories.find(params[:category_id])
    end

    def set_task
        @task = @category.tasks.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:task_name, :task_details, :priority, :completion_status, :due_date)
    end
end
