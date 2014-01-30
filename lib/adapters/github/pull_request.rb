require 'octockit'

module Adapters
  class Github < Base
    class PullRequest
      attr_accessor :attributes

      def initialize(attributes)
        @attributes = attributes
      end

      def self.where(query)
        Client.new.search_issues("#{query}+in:title+type:pull_request").items.map do |item|
          new(item)
        end
      end

      def repo_name
        @repo_name ||= @attributes.rels[:self].href.match(/\/repos\/(.*)\/issues/)[1]
      end

      def ready!
        Client.new.add_comment(repo_name, attributes.number, 'This Pull Request is accepted and ready to merge!')
      end
    end
  end
end