class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @contracts = @user.contracts.paginate(page: params[:page])
  end
end
