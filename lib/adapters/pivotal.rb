module Adapters
  # TODO: create a base class once we add more adapters.
  class Pivotal < Base
    subscribe! :pull_request

    ID_MATCHER = /PT\s*(\d+)/
    URL_MATCHER = /pivotaltracker.*\/(\d+)/
    MATCHER = /#{ID_MATCHER}|#{URL_MATCHER}/

    attr_reader :payload, :story_id

    def initialize(options)
      @payload = options
      extract_information!
    end

    def process_pull_request
      puts "[Pivotal] processing pull request: #{text}"
    end

    private

    def extract_information!
      @story_id = extract_ids(text.match(MATCHER)).first
    end

    def pr
      @pr ||= payload.pull_request
    end

    def extract_ids(match_data)
      return [ ] unless match_data
      match_data.captures.select { |s| s =~ /\d+/ }.map { |s| s.to_i }
    end

    def text
      pr.title + pr.body
    end
  end
end

