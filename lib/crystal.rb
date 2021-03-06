begin
  require 'bundler'
rescue
  require 'rubygems'
  require 'bundler'
end

Bundler.require(:default)

Dotenv.load

require 'config'
require 'models'
require 'hookers'
require 'adapters'

class Crystal < Sinatra::Base
  use Hookers::Github
  use Hookers::Deploy
  use Hookers::Pivotal

  get '/' do
    "At #{Time.now} it works!"
  end
end
