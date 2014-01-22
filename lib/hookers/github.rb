module Hookers
  class Github < Sinatra::Base
    post '/github' do
      puts request.env.inspect
      event = request.env["HTTP_X_GITHUB_EVENT"].to_sym
      payload = Hashie::Mash.new(JSON.parse(params[:payload] || "{}"))
      Adapters.process(event, payload)
      :ok
    end
  end
end
