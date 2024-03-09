class Api::V1::CurrentUserController < ApplicationController
  before_action :set_user_data
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes], status: :ok
    # render json: {
    #   user: @user,
    #   categories: @categories,
    #   tasks: @tasks
    # }
  end

  def all
    render json: @tasks
  end

  private

  def set_user_data
    @user = current_user
    @categories = @user.categories
    # @tasks = Task.joins(:category).where(categories: { user_id: @user.id })
    @tasks = @user.tasks
  end
end
