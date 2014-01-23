module Hookers
  class Deploy < Sinatra::Base
    post '/deploy' do
      payload = Hashie::Mash.new(JSON.parse(params[:payload] || "{}"))
      Adapters.process(:deploy, payload)
      "Ok"
    end
  end
end
