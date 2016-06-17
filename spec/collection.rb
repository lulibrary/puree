require 'spec_helper'

describe 'Collection' do

  it '#new' do
    endpoint = ENV['PURE_ENDPOINT']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    p = Puree::Collection.new(resource: :dataset,
                              endpoint: endpoint,
                              username: username,
                              password: password)
    expect(p).to be_an_instance_of Puree::Collection
  end

  describe 'data retrieval' do
    before(:all) do
      endpoint = ENV['PURE_ENDPOINT']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      @p = Puree::Collection.new(resource: :dataset,
                                 endpoint: endpoint,
                                 username: username,
                                 password: password)
      @metadata = @p.find limit: 5
    end

    it '@metadata' do
      expect(@metadata).to be_an_instance_of(Array)
    end

  end

end