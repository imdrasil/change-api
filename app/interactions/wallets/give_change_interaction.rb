module Wallets
  # represents interaction of giving change from account's wallet
  class GiveChangeInteraction
    def initialize(options = {})
      @account = Account.find(options[:account_id])
      @change = @account.wallet.change(parse_params(options[:change]))
      @account.save
    rescue ActiveRecord::ActiveRecordError
    end

    def parse_params(options)
      if options.is_a? Integer
        options
      else
        (options[:banknotes] || 0) * 100 + options[:coins]
      end
    end

    def as_json(_options = {})
      if @account.nil?
        { error: 'Account not found' }
      elsif @change.present?
        @change.as_json
      else
        { error: 'Can not give change for that sum' }
      end
    end
  end
end
