require 'spec_helper'

describe 'Server' do

  it '#new' do
    extractor = Puree::Extractor::Server.new config
    expect(extractor).to be_a Puree::Extractor::Server
  end

  describe 'data retrieval' do
    before(:all) do
      @extractor = Puree::Extractor::Server.new config
      @p = @extractor.find
    end

    it '#find' do
      expect(@p).to be_a Puree::Model::Server
    end

    it '#version' do
      expect(@p.version).to be_a String if @p.version
    end

  end

end