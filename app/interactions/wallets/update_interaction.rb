module Wallets
  # interaction for wallet coin count changes
  class UpdateInteraction
    def initialize(options = {})
      @account = Account.find(options[:account_id])
      if options[:type] == 'add'
        @account.wallet.add(options)
      elsif options[:type] == 'remove'
        @account.wallet.remove(options)
      end
      @account.save
    rescue ActiveRecord::ActiveRecordError
    end

    def as_json(_options = {})
      if @account && @account.errors.blank?
        @account.serialize
      else
        { error: @account.errors }
      end
    end
  end
end
