module Hookers
  class Pivotal < Sinatra::Base
    post '/pivotal' do
      payload = Hashie::Mash.new(JSON.parse(request.body.read))
      Adapters.process(:story, payload)
      "Ok"
    end
  end
end
