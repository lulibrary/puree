require 'spec_helper'

describe 'Collection' do

  def new
    base_url = ENV['PURE_BASE_URL']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    @p = Puree::Collection.new(resource: :dataset,
                              base_url: base_url,
                              username: username,
                              password: password,
                              basic_auth: true)
  end

  it '#new' do
    new
    expect(@p).to be_an_instance_of(Puree::Collection)
  end

  describe 'data retrieval' do
    before(:all) do
      new
      @metadata = @p.find limit: 5
    end

    it 'collection' do
      expect(@metadata).to be_an_instance_of(Array)
    end

  end

  describe 'data retrieval instance' do
    before(:all) do
      new
      @metadata = @p.find limit: 5,
                          instance: true
    end

    it 'collection' do
      expect(@metadata).to be_an_instance_of(Array)
    end

    it 'collection item' do
      expect(@metadata[0]).to be_an_instance_of(Puree::Dataset)
    end

  end

end