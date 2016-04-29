require 'spec_helper'

describe 'DatasetCollection' do

  it '#new' do
    p = Puree::DatasetCollection.new
    expect(p).to be_an_instance_of Puree::DatasetCollection
  end

  describe 'data retrieval' do
    before(:all) do
      endpoint = ENV['PURE_ENDPOINT']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      @p = Puree::DatasetCollection.new
      @p.get endpoint: endpoint,
             username: username,
             password: password
    end

    it '#UUID' do
      expect(@p.UUID).to be_an_instance_of(Array)
    end

  end

end