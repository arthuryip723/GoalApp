class GoalsController < ApplicationController
  before_action :require_signin
  def index
    @public_goals = Goal.where(category: "public")
    @private_goals = current_user.goals.where(category: "private")
    # fail
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = current_user.goals.find(params[:id])
  end

  def update
    @goal = current_user.goals.find(params[:id])
    if @goal.update(goal_params)
      redirect_to @goal
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:body, :category)
  end
end
