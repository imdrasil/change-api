# represents class for validates account wallet data
class WalletValidator < ActiveModel::Validator
  attr_accessor :wallet

  def validate(record)
    @wallet = record._wallet
    if forbidden_keys?
      record.errors[:wallet] << 'Not allowed coins'
    elsif forbidden_numbers?
      record.errors[:wallet] << 'One of coins has unsuitable state'
    end
  end

  def forbidden_keys?
    (wallet.keys - Wallet::STR_ALLOWED_COINS).present?
  end

  def forbidden_numbers?
    wallet.present? && wallet.any? { |_, v| !v.is_a?(Integer) || v < 0 }
  end
end
