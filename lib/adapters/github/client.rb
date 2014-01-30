module Adapters
  class Github < Base
    class Client
      def self.instance
        @instance ||= Octokit::Client.new :access_token => ENV['GH_TOKEN']
      end
    end
  end
end
