class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = 'User creation failed'
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @statuses = @user.games.select('count(games.id) AS count').group(:status).order(:status)
      @trophies = @user.trophies.uniq
    else
      render file: '/public/404'
    end
  end

  def index
    @users = User.select('count(user.games.where(status = 1)) AS count').group(:user_id).order(:count)
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
