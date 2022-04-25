# used to start the application

dev = ENV['RACK_ENV'] == 'development'

require 'rack/unreloader'

# reload files
Unreloader = Rack::Unreloader.new(subclasses: %w[Roda], reload: dev) { Paday }
Unreloader.require './lib/paday.rb'

# run app
run(dev ? Unreloader : Paday.freeze.app)
