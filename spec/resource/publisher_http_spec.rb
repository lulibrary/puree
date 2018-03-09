require 'spec_helper'

describe 'Publisher' do

  it '#new' do
    p = Puree::Extractor::Publisher.new config
    expect(p).to be_a Puree::Extractor::Publisher
  end

  before(:all) do
    request :publisher
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Publisher
    end

    it '#name' do
      expect(@p.name).to be_a String if @p.name
    end

  end

end