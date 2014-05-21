module Adapters
  class Email < Base
    subscribe! :deploy

    attr_reader :payload

    def initialize(payload)
      @payload = payload
    end

    def process_deploy
      deploy_email
    end

    private

    def deploy_email
      Mail.new do
        to ENV['DEPLOY_RECIPIENTS']
        from ENV['EMAIL_FROM']
        subject "[We Heart It] Ruby code deployed to production at #{Time.now.strftime("%D %R")} UTC"
      end.tap do |m|
        # I have no idea how to pass variables to the mail object on the constructor.
        m.body = payload.text
        m.deliver!
      end
    end
  end
end
