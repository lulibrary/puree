require 'spec_helper'

describe 'Server' do

  it '#new' do
    p = Puree::Server.new
    expect(p).to be_an_instance_of Puree::Server
  end

  describe 'data retrieval' do
    before(:all) do
      base_url = ENV['PURE_BASE_URL']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      @p = Puree::Server.new(base_url: base_url,
                              username: username,
                              password: password,
                              basic_auth: true)
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