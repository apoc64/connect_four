class TrophiesController < ApplicationController
  def new
    user = User.find(params[:user_id])
    trophy = user.win_trophy
    redirect_to user_trophy_path(user, trophy)
  end

  def show
    @user = User.find(params[:user_id])
    @trophy = Trophy.find(params[:id])
  end
end
