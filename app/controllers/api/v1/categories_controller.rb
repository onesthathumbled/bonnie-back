class Api::V1::CategoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :set_category, only: %i[show edit update destroy]


    def index
        @categories = @user.categories.all
        render json: @categories
    end

    def show

    end

    def new
        @category = @user.categories.build
    end

    def create
        @category = @user.categories.build(category_params)
        if @category.save
            render json: {
                message: 'Category created.'
            }
        else
            render json: 'Error'
        end
    end

    def edit

    end

    def update
        if @category.update(category_params)

        else

        end
    end

    def destroy
        @category.destroy
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    end

    def set_category
        @category = @user.categories.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:category_name, :category_details)
    end
end
