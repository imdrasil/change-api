# represents controller to interact with account's wallet
class WalletsController < ApplicationController
  def update
    render json: Wallets::UpdateInteraction.new(params)
  end

  def change
    render json: Wallets::GiveChangeInteraction.new(params)
  end
end
