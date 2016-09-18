class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
  end

  def edit
    @request = CatRentalRequest.find_by_id(params[:id])
    @cats = Cat.all
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      @errors = @request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end

  def update
    pending_params = request_params
    pending_params[:status] = "PENDING"
    @request = CatRentalRequest.find_by_id(params[:id])
    if @request.update(pending_params)
      redirect_to cat_url(@request.cat)
    else
      @errors = @request.errors.full_messages
      @cats = Cat.all
      render :edit
    end
  end

  def approve
    @request = CatRentalRequest.find_by(id: params[:id])
    @request.approve!
    # @cat =
    redirect_to cat_url(@request.cat)
  end

  def destroy
  end

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
