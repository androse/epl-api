require 'net/http'
require 'json'

module EplApi
  class HttpClient

    attr_reader :uri

    def initialize(uri, params)
      @uri = URI(uri)
      @uri.query = URI.encode_www_form(params)
    end

    def get
      res = Net::HTTP.get_response(uri)
      JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    end

    def self.get(uri, params)
      http_client = HttpClient.new(uri, params)
      http_client.get()
    end

  end
end
