require 'spec_helper'

describe 'Server' do

  it '#new' do
    extractor = Puree::Extractor::Server.new url: ENV['PURE_URL']
    expect(extractor).to be_a Puree::Extractor::Server
  end

  describe 'data retrieval' do
    before(:all) do
      @extractor = Puree::Extractor::Server.new(url: ENV['PURE_URL'])
      @extractor.basic_auth username: ENV['PURE_USERNAME'],
                            password: ENV['PURE_PASSWORD']

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