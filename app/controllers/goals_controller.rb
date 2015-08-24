class GoalsController < ApplicationController
  before_action :require_signin
  def index
    @public_goals = Goal.where(category: "public").includes(:user)
    @private_goals = current_user.goals.where(category: "private").includes(:user)
    @completed_goals = current_user.goals.where(status: "complete")
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
    @goal = current_user.goals.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  def complete
    @goal = current_user.goals.find(params[:id])
    # @goal.status = 'complete'
    # @goal.save!
    @goal.update!(status: 'complete')
    # fail
    redirect_to goals_url
  end

  def show
    @goal = Goal.find(params[:id])
    @comments = @goal.comments
    @cheers_count = @goal.cheers.count
  end

  def cheer
    @cheer = current_user.cheers.new(goal_id: params[:id])
    unless @cheer.save
      flash[:errors] = @cheer.errors.full_messages
    end
    redirect_to goal_url(params[:id])
  end

  private
  def goal_params
    params.require(:goal).permit(:body, :category)
  end
end
