module Accounts
  # represents interaction for account creation
  class CreateInteraction
    def initialize(_options = {})
      @account = Account.create(token: Account.generate_token)
    rescue ActiveRecord::ActiveRecordError
    end

    def as_json(_options = {})
      if @account.errors.blank?
        @account.as_json
      else
        { error: @account.errors }
      end
    end
  end
end
