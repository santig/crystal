module Hookers
  class Github < Sinatra::Base
    post '/github' do
      puts request.inspect
      event = request.env["X-Github-Event"].to_sym
      payload = Hashie::Mash.new(JSON.parse(params[:payload]))
      Adapters.process(event, payload)
      :ok
    end
  end
end
