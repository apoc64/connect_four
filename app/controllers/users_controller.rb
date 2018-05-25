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
    # @users = User.select("users.*, count(games.id) as wins").join(:games).group(:user).order("wins desc")
    # binding.pry
    #User.select('count(user.games.where(status = 1)) AS count').group(:user_id).order(:count)
    users = User.all
    mapped_users = users.map do |u|
      [u, u.games.where(status: 1).count]
    end
    @users = mapped_users.sort_by do |u|
      u[1]
    end.reverse[0..4]

    fast_map = users.map do |u|
      g = u.games.min_by do |game|
        # binding.pry
        if game.status == 1
          (game.updated_at - game.created_at)
        else
          9999
        end
      end
      [g, (g.updated_at - g.created_at).round(2)]
    end
    @fastest = fast_map.sort_by do |u|
      u[1]
    end[0..4]
    # binding.pry
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
