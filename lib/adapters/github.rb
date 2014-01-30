module Adapters
  class Github < Base
    subscribe! :story

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def process_story
      if payload.highlight == "accepted"
        PullRequest.where(story_id).each{ |pr| pr.ready! }
      end
    end
  end
end
