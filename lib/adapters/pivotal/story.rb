module Adapters
  class Pivotal < Base
    class Story
      attr_reader :project_id, :story_id, :labels

      def initialize(opts = {})
        @project_id = opts[:project_id]
        @labels = opts[:labels]
        @story_id = opts[:story_id]
      end

      def self.find(story_id)
        story = Client.new.get("stories/#{story_id}")
        new(project_id: story.project_id, labels: story.labels, story_id: story.id)
      end
    end
  end
end
