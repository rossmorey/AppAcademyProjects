class GoalsController < ApplicationController

  def index
    @goals = current_user.goals
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.current_user.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find(params[:id])
    if @goal.destroy
      redirecto_to goals_url
    else
      flash[:errors] = ["This goal is indestructable"]
      redirect_to goal_url(@goal)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :visibility, :description, :private, :completed)
  end
end
