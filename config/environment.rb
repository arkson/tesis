# Load the rails application
require File.expand_path('../application', __FILE__)
require "pdf/writer"
require "pdf/simpletable"
# Initialize the rails application
Tesis::Application.initialize!

Mime::Type.register 'application/pdf', :pdf

