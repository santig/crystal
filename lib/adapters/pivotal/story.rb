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
      
      def comment(text)
        Client.new.post("projects/#{project_id}/#{story_path}/comments", text: text)
      end
      
      def start
        Client.new.put("#{story_path}", current_state: "started")
      end
      
      def finish
        Client.new.put("#{story_path}", current_state: "finished")
      end
      
      def story_path
        "stories/#{story_id}"
      end
    end
  end
end
