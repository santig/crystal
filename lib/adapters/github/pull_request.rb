module Adapters
  class Github < Base
    class PullRequest
      attr_accessor :attributes

      def initialize(attributes)
        @attributes = attributes
      end

      def self.where(query)
        Client.instance.search_issues("#{query}+in:title+type:pull_request").items.map do |item|
          new(item)
        end
      end

      def repo_name
        @repo_name ||= @attributes.rels[:self].href.match(/\/repos\/(.*)\/issues/)[1]
      end

      def ready!(message="This Pull Request is accepted")
        Client.instance.add_comment(repo_name, attributes.number, "#{message} and it's ready to merge!")
      end
    end
  end
end
