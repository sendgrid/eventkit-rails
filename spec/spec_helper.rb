require 'rubygems'
require 'factory_girl_rails'
require 'rspec_api_test'
require 'rails_helper'
require 'rspec/rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

RSpec.configure do |config|
	config.include FactoryGirl::Syntax::Methods
end