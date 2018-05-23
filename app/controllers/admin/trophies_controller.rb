class Admin::TrophiesController < Admin::BaseController
  def new
    @trophy = Trophy.new
  end

  def create
    trophy = Trophy.new(trophy_params)
    if trophy.save
      redirect_to admin_trophy_path(trophy)
    else
      flash[:error] = 'Trophy creation failed'
      redirect_to new_trophy_path
    end
  end

  def show
    @trophy = Trophy.find(params[:id])
  end

  def index
    @trophies = Trophy.all
  end

  def destroy
    trophy = Trophy.find(params[:id])
    trophy.destroy

    redirect_to admin_trophies_path
  end

  def edit
    @trophy = Trophy.find(params[:id])
  end

  def update
    @trophy = Trophy.find(params[:id])
    @trophy.update(trophy_params)
    redirect_to admin_trophies_path
  end

  private

  def trophy_params
    params.require(:trophy).permit(:name, :description, :image)
  end
end
