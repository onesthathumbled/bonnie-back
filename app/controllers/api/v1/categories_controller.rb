class Api::V1::CategoriesController < ApplicationController
    before_action :set_user
    before_action :set_category, only: %i[show edit update destroy]


    def index
        @categories = @user.categories
        render json: @categories
    end

    def show
        render json: @category
    end

    def new
        @category = @user.categories.build
    end

    def create
        @category = @user.categories.build(category_params)
        if @category.save
            render json: @category
        else
            render json: { error: "Failed to create category" }, status: :unprocessable_entity
        end
    end

    def edit

    end

    def update
        if @category.update(category_params)
            render json: @category
        else
            render json: { error: "Failed to create task" }, status: :unprocessable_entity
        end
    end

    # Soft deletion
    def destroy
        @category.destroy
    end

    private

    def set_user
        @user = current_user
    end

    def set_category
        @category = @user.categories.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:category_name, :category_details)
    end
end
