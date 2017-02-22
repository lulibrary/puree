require 'spec_helper'

describe 'Server' do

  it '#new' do
    p = Puree::Extractor::Server.new url: ENV['PURE_URL']
    expect(p).to be_a Puree::Extractor::Server
  end

  describe 'data retrieval' do
    before(:all) do
      @p = Puree::Extractor::Server.new(url: ENV['PURE_URL'])
      @p.basic_auth username: ENV['PURE_USERNAME'],
                    password: ENV['PURE_PASSWORD']

      @metadata = @p.find
    end

    it '#find' do
      expect(@metadata).to be_a(Hash)
    end

    it '#find' do
      expect(@metadata).not_to be_empty
    end

    it '#version' do
      expect(@p.version).to be_a(String)
    end

  end

end