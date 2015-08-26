class UsersController < ApplicationController
  before_filter :authenticate_user!

  def update
    user = current_user
    user.update_attributes(filtered_params)
    render json: { status: :success, user: user }
  end

  private

    def filtered_params
      params.require(:user).permit(:fullname, :email, :password, :password_confirmation)
    end

end
