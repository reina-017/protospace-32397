class UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])
    # @prototypes = @user.prototypes
    # @name = @user.name
  end
end
