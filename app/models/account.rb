# represents user's account and wallet
class Account < ActiveRecord::Base
  attr_accessor :wallet

  validates_with ::WalletValidator

  after_initialize :load_wallet
  before_validation :serialize_wallet

  def serialize(type = :pretty)
    case type
    when :pretty
      as_json(except: [:_wallet], include: [:wallet])
    else
      as_json
    end
  end

  private

  def load_wallet
    self.wallet = Wallet.new(_wallet)
  end

  def serialize_wallet
    self._wallet = wallet.as_json
  end

  class << self
    def generate_token
      10.times do
        token = SecureRandom.hex(12)
        return token unless exists?(token)
      end
      nil
    end
  end
end
