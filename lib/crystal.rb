begin
  require 'bundler'
rescue
  require 'rubygems'
  require 'bundler'
end

Bundler.require(:default)

require 'hookers'
require 'adapters'

class Crystal < Sinatra::Base
  use Hookers::Github
end

#   get '/pr' do
#     payload = Hashie::Mash.new(JSON.parse(params["payload"]))
#     payload.action
#     payload.title
#     payload.
#
#   "pull_request" {}
#     "title"
#     "body"=>"",
#     "created_at"=>"2014-01-21T19:42:03Z",
#     "updated_at"=>"2014-01-21T19:42:03Z",
#     "closed_at"=>nil,
#     "merged_at"=>nil,
#     "merge_commit_sha"=>nil,
#     "user"=>
#         {"login"=>"jpemberthy",}
#       }
#   end
#
#   PT_ID_MATCHER = /PT\s*(\d+)/
#   PT_URL_MATCHER = /pivotaltracker.*\/(\d+)/
#
#   PIVOTAL_MATCH = /#{PT_ID_MATCHER}|#{PT_URL_MATCHER}/
#
# end
