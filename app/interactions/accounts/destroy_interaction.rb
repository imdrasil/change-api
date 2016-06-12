module Accounts
  # represents interaction for account destroy
  class DestroyInteraction
    def initialize(options = {})
      @response = Account.destroy(options[:id])
    rescue ActiveRecord::ActiveRecordError
    end

    def as_json(_options = {})
      if @response
        { status: 'ok' }
      else
        { error: 'Cannot destroy account' }
      end
    end
  end
end
