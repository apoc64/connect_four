class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @cells = @game.cells.order(:id)
  end

  def update
    game = Game.find(params[:game_id])
    game.move(params[:column].to_i)
    redirect_to user_game_path(game.user, game)
  end

  def create #why wont it hit?
  end

  def new
    user = User.find(params[:user_id])
    game = user.create_game
    redirect_to user_game_path(user, game)
  end
end
