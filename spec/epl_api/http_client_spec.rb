require 'spec_helper'

describe EplApi::HttpClient do

  describe '::get' do
    it 'should initialize HttpClient and call get with the given uri' do
      http_client = instance_double('EplApi::HttpClient')
      uri = 'uri'

      expect(described_class).to receive(:new).
        with(uri).
        and_return(http_client)

      expect(http_client).to receive(:get)

      described_class.get(uri)
    end
  end

end
