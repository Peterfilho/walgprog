require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

require 'support/capybara'
require 'capybara-screenshot/rspec'
require 'support/shoulda'
require 'support/database_cleaner'
require 'support/file_spec_helper'

require 'support/matchers/have_flash'
require 'support/matchers/have_message'
require 'support/matchers/have_selectize'
require 'support/matchers/have_destroy_link'
require 'support/matchers/have_breadcrumbs'

require 'support/helpers/form'
require 'support/helpers/link'
require 'support/helpers/breadcrumbs'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Warden::Test::Helpers
  config.include Helpers::Form, type: :feature
  config.include Helpers::Link, type: :feature
  config.include Helpers::Breadcrumbs, type: :feature

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
