require 'spec_helper'

describe 'Server' do

  it '#new' do
    p = Puree::Extractor::Server.new base_url: ENV['PURE_BASE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Server
  end

  describe 'data retrieval' do
    before(:all) do
      @p = Puree::Extractor::Server.new(base_url: ENV['PURE_BASE_URL'])
      @p.basic_auth username: ENV['PURE_USERNAME'],
                    password: ENV['PURE_PASSWORD']

      @metadata = @p.find
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#find' do
      expect(@metadata).not_to be_empty
    end

    it '#version' do
      expect(@p.version).to be_an_instance_of(String)
    end

  end

end