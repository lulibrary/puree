require 'spec_helper'

describe 'Collection' do

  it '#new' do
    base_url = ENV['PURE_BASE_URL']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    p = Puree::Collection.new(resource: :dataset,
                              base_url: base_url,
                              username: username,
                              password: password,
                              basic_auth: true
    )
    expect(p).to be_an_instance_of Puree::Collection
  end

  describe 'data retrieval' do
    before(:all) do
      base_url = ENV['PURE_BASE_URL']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      @p = Puree::Collection.new(resource: :dataset,
                                 base_url: base_url,
                                 username: username,
                                 password: password,
                                 basic_auth: true)
      @metadata = @p.find limit: 5
    end

    it '@metadata' do
      expect(@metadata).to be_an_instance_of(Array)
    end

  end

end