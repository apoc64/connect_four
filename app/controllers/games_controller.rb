class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    if current_user && @game.user == current_user
      @cells = @game.cells.order(:id)
    else
      render file: '/public/404'
    end
  end

  def update
    game = Game.find(params[:game_id])
    game.move(params[:column].to_i)
    redirect_to user_game_path(game.user, game)
  end

  def new
    user = User.find(params[:user_id])
    game = user.create_game
    redirect_to user_game_path(user, game)
  end
end
