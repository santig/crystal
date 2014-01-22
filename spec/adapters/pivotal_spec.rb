require 'spec_helper'

module Adapters
  describe Pivotal do

    def new_payload(opts = {})
      Pivotal.new Hashie::Mash.new(payload: { pull_request: opts })
    end

    describe "#story_id" do
      it "is nil if the payload doesn't contain a PT ID" do
        new_payload(title: "Hello World!", body: "This is the body").story_id.should == nil
      end

      describe "when the title|body of the payload contains the PT ID" do
        it "returns the story_id" do
          new_payload(title: "PT 12345. Hello World!", body: "This is the body").story_id.should == 12345
          new_payload(title: "PT 12345 Hello World!", body: "This is the body").story_id.should == 12345
          new_payload(title: "Hello World!", body: "PT 12345").story_id.should == 12345
          new_payload(title: "Hello World!", body: "https://www.pivotaltracker.com/story/show/61930518 This is the body").story_id.should == 61930518
        end
      end
    end
  end
end
