ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'
require 'database_cleaner'
require 'capybara'
require 'capybara/rails'
require 'capybara/rspec'
require 'headless'

ActiveRecord::Migration.maintain_test_schema!
DatabaseCleaner.clean_with(:truncation)

Capybara.javascript_driver = :webkit
Capybara.default_wait_time = 50
Capybara.ignore_hidden_elements = false

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  config.include Capybara::Angular::DSL

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
