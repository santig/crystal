require 'adapters/pivotal/client'
require 'adapters/pivotal/story'
require 'adapters/pivotal/label'

module Adapters
  # TODO: create a base class once we add more adapters.
  class Pivotal < Base
    subscribe! :pull_request

    ID_MATCHER = /PT\s*(\d+)/
    URL_MATCHER = /pivotaltracker.*\/(\d+)/
    MATCHER = /#{ID_MATCHER}|#{URL_MATCHER}/

    attr_reader :payload, :story_id

    def initialize(payload)
      @payload = payload
      extract_information!
    end

    def process_pull_request
      extract_information!

      puts "[Pivotal] processing pull request: #{text}"

      # TODO: create pull_request model if we handle more github events
      if opened?
        Label.create(story_id: story_id, name: "pr-requested")
      elsif closed?
        Label.delete(story_id: story_id, name: "pr-requested")
      elsif merged?
        Label.create(story_id: story_id, name: "merged")
      end

      puts "[Pivotal] processed pull request: #{text}"
    end

    private

    # ****************** PR METHODS ***************************
    # *********************************************************
    def opened?

    end

    def closed?

    end

    def merged?

    end

    def pr
      @pr ||= payload.pull_request
    end

    # we may need to define this for each event type
    def text
      pr.title + pr.body
    end
    # ****************** END PR METHODS ***************************

    def extract_information!
      @story_id = extract_ids(text.match(MATCHER)).first
    end


    def extract_ids(match_data)
      return [ ] unless match_data
      match_data.captures.select { |s| s =~ /\d+/ }.map { |s| s.to_i }
    end
  end
end

