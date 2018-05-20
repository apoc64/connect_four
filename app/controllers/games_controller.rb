class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @cells = @game.cells
  end

  def update
    game = Game.find(params[:game_id])
    game.move(params[:column].to_i)
    redirect_to game_path(game)
  end
end
