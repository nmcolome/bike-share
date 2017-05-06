ENV["RACK_ENV"] ||= "test"

require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
Capybara.app = BikeShareApp

RSpec.configure do |c|
  c.include Capybara::DSL
  c.before(:all) do
    DatabaseCleaner.clean
  end
  c.after(:all) do
    DatabaseCleaner.clean
  end
end
