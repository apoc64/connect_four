class GamesController < ApplicationController
  def show
    @cells = Game.find(params[:id]).cells
  end
end
