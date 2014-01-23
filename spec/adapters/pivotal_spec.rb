require 'spec_helper'

module Adapters
  describe Pivotal do

    describe "#extract_information!" do
      let(:pivotal) { Pivotal.new mashie }

      it "story_ids is an emptry array if the text doesn't contain a PT ID" do
        pivotal.extract_information!("this is the text without a story")
        pivotal.story_ids.should == []
      end

      describe "when the text contains the PT ID or URL" do
        it "parses the story_id when it's in the PT ID format" do
          pivotal.extract_information!("PT 12345. Hello World!")
          pivotal.story_ids.should == [12345]
        end

        it "parses the story_id when it's in the URL format" do
          pivotal.extract_information!("https://www.pivotaltracker.com/story/show/61930518 This is the body")
          pivotal.story_ids.should == [61930518]
        end

        it "parses multiple story ids" do
          pivotal.extract_information!("more text https://www.pivotaltracker.com/story/show/61930518 another story PT 12345")
          pivotal.story_ids.should =~ [61930518,12345]
        end
      end
    end

    describe "process_pull_request" do
      describe "when the pull request is opened" do
        it "adds the 'pr-requested' label to the story" do
          pivotal = Pivotal.new mashie({ action: "opened", pull_request: { title: "PT 12345. Hello World!", body: "" } })
          Pivotal::Label.should_receive(:create).with(story_id: 12345, name: "pr-requested")
          pivotal.process_pull_request
        end
      end

      describe "when the pull request is closed" do
        it "removes the 'pr-requested' label from the story" do
          pivotal = Pivotal.new mashie({ action: "closed", pull_request: { title: "PT 12345. Hello World!", body: "", closed_at: Time.now } })
          Pivotal::Label.should_receive(:destroy).with(story_id: 12345, name: "pr-requested")
          pivotal.process_pull_request
        end
      end

      describe "when the pull request is merged" do
        it "adds the 'merged' label to the story" do
          pivotal = Pivotal.new mashie({ action: "closed", pull_request: { title: "PT 12345. Hello World!", body: "", merged_at: Time.now } })
          Pivotal::Label.should_receive(:create).with(story_id: 12345, name: "merged")
          pivotal.process_pull_request
        end
      end
    end
  end
end
