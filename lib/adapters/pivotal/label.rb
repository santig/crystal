module Adapters
  class Pivotal < Base
    class Label
      attr_reader :story, :name

      def initialize(opts = {})
        @story = Story.find opts[:story_id]
        @name = opts[:name]
      end

      def save
        Client.new.post(base_resources_path, name: self.name)
      end

      def destroy
        label = story.labels.detect { |l| l.name == self.name }
        delete_path = "#{base_resources_path}/#{label.id}"
        Client.new.delete(delete_path)
      end

      def self.create(opts = {})
        label = new(opts)
        label.save
      end

      def self.destroy(opts = {})
        label = new(opts)
        label.destroy
      end

      private

      def base_resources_path
        "projects/#{story.project_id}/stories/#{story.story_id}/labels"
      end
    end
  end
end
