class UsersController < ApplicationController
  before_action :authenticate_user!

  def available_users
    users = User.all_except(current_user)

    respond_to do |format|
      format.json { render json: users }
    end
  end
end
