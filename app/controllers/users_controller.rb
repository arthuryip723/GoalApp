class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @public_goals = @user.goals.where(category: "public")
    if current_user == @user
      @private_goals = @user.goals.where(category: "private")
    end
    @comments = @user.comments
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
