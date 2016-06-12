# controller to handle user's account interactions
class AccountsController < ApplicationController
  def create
    render json: Accounts::CreateInteraction.new(params)
  end

  def destroy
    render json: Accounts::DestroyInteraction.new(params)
  end

  def show
    render json: Accounts::ShowInteraction.new(params)
  end
end
