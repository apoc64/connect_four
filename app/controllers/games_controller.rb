class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @cells = @game.cells.order(:id)
  end

  def update
    game = Game.find(params[:game_id])
    game.move(params[:column].to_i)
    redirect_to game_path(game)
  end

  def create #why wont it hit?
  end

  def new
    user = User.last
    game = user.create_game
    redirect_to game_path(game)
  end
end
