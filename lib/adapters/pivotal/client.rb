module Adapters
  class Pivotal < Base
    class Client
      include HTTParty
      base_uri "https://www.pivotaltracker.com/services/v5"
      attr_accessor :token

      def initialize(token = nil)
        @token = token || ENV['PT_TOKEN']
      end

      def get(path, params = {})
        parse_response self.class.get("/#{path}", authenticated(params: params))
      end

      def post(path, body = {})
        parse_response self.class.post("/#{path}", authenticated(body: body))
      end

      def delete(path)
        parse_response self.class.delete("/#{path}", authenticated)
      end

      def put(path, body = {})
        parse_response self.class.put("/#{path}",authenticated(body: body))
      end

      private

      def authenticated(opts = {})
        opts.merge(headers: { "X-TrackerToken" => @token })
      end

      def parse_response(response)
        Hashie::Mash.new response.parsed_response
      end
    end
  end
end
