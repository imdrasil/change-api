module Accounts
  # represent interaction for showing account data
  class ShowInteraction
    def initialize(options = {})
      @account = Account.find_by_token(options[:id])
    end

    def as_json(_options = {})
      if @account
        @account.serialize
      else
        { error: 'Can not load account with such token' }
      end
    end
  end
end
