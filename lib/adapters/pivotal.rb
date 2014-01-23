require 'adapters/pivotal/client'
require 'adapters/pivotal/story'
require 'adapters/pivotal/label'

module Adapters
  # TODO: create a base class once we add more adapters.
  class Pivotal < Base
    subscribe! :pull_request
    subscribe! :deploy

    ID_MATCHER = /PT\s*(\d+)/
    URL_MATCHER = /pivotaltracker.*\/(\d+)/
    MATCHER = /#{ID_MATCHER}|#{URL_MATCHER}/

    attr_reader :payload, :story_ids

    def initialize(payload)
      @payload = payload
    end

    def process_pull_request
      pr = PullRequest.new(payload)
      extract_information!(pr.text)

      story_ids.each do |story_id|
        if pr.opened?
          Label.create(story_id: story_id, name: "pr-requested")
        elsif pr.closed?
          Label.destroy(story_id: story_id, name: "pr-requested")
        elsif pr.merged?
          Label.create(story_id: story_id, name: "merged")
        end
      end
    end

    def process_deploy
      extract_information!(payload.text)

      story_ids.each do |story_id|
        Label.create(story_id: story_id, name: "deployed")
      end
    end

    def extract_information!(text)
      @story_ids ||= text.scan(MATCHER).flatten.compact.map(&:to_i)
    end
  end
end

