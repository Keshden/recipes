class ChefsController < ApplicationController
before_action :set_chef, only: [:show, :edit, :update]

  def index
    @chefs = Chef.all
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefName} to the Recipes App"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "Account successfully updated"
      redirect_to @chef
    else
      render 'edit'
    end
  end

  def show
  end

  private

  def chef_params
    params.require(:chef).permit(:chefName, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

end
