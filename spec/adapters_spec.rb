require 'spec_helper'

describe Adapters do
  describe "subscribe!" do
    class Fake
      extend Adapters::Subscribable
    end

    it "subscribes a class to a service" do
      Fake.send(:subscribe!, :zomgdude)
      Adapters.listeners[:zomgdude].should == [ Fake ]
    end
  end
end
