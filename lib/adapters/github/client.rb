require 'octockit'

module Adapters
  class Github < Base
    class Client
      attr_reader :client

      def initialize
        @client = Octokit::Client.new :access_token => ENV['GH_TOKEN']
      end

    end
  end
end