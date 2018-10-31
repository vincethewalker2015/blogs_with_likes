# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Initialize the Image Upload Application
require 'carrierwave/orm/activerecord'
