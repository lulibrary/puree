require 'spec_helper'

describe 'Publisher' do

  it '#new' do
    p = Puree::Extractor::Publisher.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Publisher
  end

  before(:all) do
    request :publisher
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Publisher
    end

    it '#name' do
      expect(@p.name).to be_an_instance_of(String)
    end

  end

end