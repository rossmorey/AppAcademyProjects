class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
  end

  def edit
    @request = CatRentalRequest.find_by_id(params[:id])
    @cats = Cat.all
  end

end
