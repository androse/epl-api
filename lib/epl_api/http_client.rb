require 'net/http'
require 'json'

module EplApi
  class HttpClient

    attr_reader :uri

    def initialize(uri)
      @uri = URI(uri)
    end

    def get
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    end

    def self.get(uri)
      http_client = HttpClient.new(uri)
      http_client.get()
    end

  end
end
