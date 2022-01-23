class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = token(@user.id)
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid email or password"}
    end
  end

  def login
    user = User.find_by("email = ?", user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: { token: token(user.id), user_id: user.id }, status: :created
    else
      render json: { errors: [ "Sorry, incorrect email or password" ] }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
