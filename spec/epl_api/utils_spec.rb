require 'spec_helper'

describe EplApi::Utils do

  describe '::camelize' do
    it 'should camelize a given string' do
      string = 'foo_bar'
      expected_output = 'fooBar'

      expect(described_class.camelize(string)).to eq expected_output
    end
  end

end
