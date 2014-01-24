begin
  require 'bundler'
rescue
  require 'rubygems'
  require 'bundler'
end

Bundler.require(:default)

Dotenv.load

require 'models'
require 'hookers'
require 'adapters'

class Crystal < Sinatra::Base
  use Hookers::Github
  use Hookers::Deploy

  get '/' do
    "At #{Time.now} it works!"
  end
end

