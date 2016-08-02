class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by(id: params[:id])
  end

  def new
    @cat = Cat.new
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      @errors = @cat.errors.full_messages
      render :new
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      @errors = @cat.errors.full_messages
      render :new
    end
  end

  def cat_params
    params.require(:cat).permit(:name, :sex, :birth_date, :color, :description)
  end
end
