class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to user_path(user)
  end

  def show
    @user = User.find(params[:id])
    @statuses = @user.games.select('count(games.id) AS count').group(:status).order(:status)
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
