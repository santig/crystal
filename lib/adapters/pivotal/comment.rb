module Adapters
  class Pivotal < Base
    class Comment
      attr_reader :story, :text

      def initialize(opts = {})
        @story = Story.find opts[:story_id]
        @text = opts[:text]
      end

      def save
        Client.new.post(base_resources_path, text: self.text)
      end

      def self.create(opts = {})
        label = new(opts)
        label.save
      end

      private

      def base_resources_path
        "projects/#{story.project_id}/stories/#{story.story_id}/comments"
      end
    end
  end
end
