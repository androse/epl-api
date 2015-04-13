require 'spec_helper'

describe EplApi::HttpClient do

  describe '#initialze' do
    it 'should set the URI with params' do
      uri = 'http://example.com'
      params = { a: 'b', c: 'd' }

      expected_uri = 'http://example.com?a=b&c=d'
      http_client = described_class.new(uri, params)

      expect(http_client.uri.to_s).to eq expected_uri
    end
  end

  describe '::get' do
    it 'should initialize HttpClient and call get with the given uri and params' do
      http_client = instance_double('EplApi::HttpClient')
      uri = 'uri'
      params = 'params'

      expect(described_class).to receive(:new).
        with(uri, params).
        and_return(http_client)

      expect(http_client).to receive(:get)

      described_class.get(uri, params)
    end
  end

end
