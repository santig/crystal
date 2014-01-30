require 'adapters/github/client'
require 'adapters/github/pull_request'

module Adapters
  class Github < Base
    subscribe! :story

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def process_story
      story = payload.primary_resources.find { |resource| resource.kind == "story" }
      return unless story

      if payload.highlight == "accepted"
        Adapters::Github::PullRequest.where(story.id).each{ |pr| pr.ready!(payload.message) }
      end
    end
  end
end
