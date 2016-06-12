require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module ChangeApi
  # represents application
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %w(interactions validators).map { |f| File.join(config.root, 'app', f) }
  end
end
