module Hookers
  class Github < Sinatra::Base
    post '/github' do
      event = request.env["HTTP_X_GITHUB_EVENT"].to_sym
      payload = Hashie::Mash.new(JSON.parse(params[:payload] || "{}"))
      Adapters.process(event, payload)
      "Ok"
    end
  end
end
