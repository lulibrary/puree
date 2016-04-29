require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Dataset.new
    expect(p).to be_an_instance_of Puree::Dataset
  end

  describe 'data retrieval' do
    before(:all) do
      endpoint = ENV['PURE_ENDPOINT']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      uuid = ENV['PURE_DATASET_UUID']
      @p = Puree::Dataset.new
      @p.get endpoint: endpoint,
             username: username,
             password: password,
             uuid: uuid
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(Array)
    end

    it '#keyword' do
      expect(@p.keyword).to be_an_instance_of(Array)
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(Array)
    end

    it '#person' do
      expect(@p.person).to be_an_instance_of(Hash)
    end

    it '#publication' do
      expect(@p.publication).to be_an_instance_of(Array)
    end

    it '#available' do
      expect(@p.available).to be_an_instance_of(Hash)
    end

    it '#geographical' do
      expect(@p.geographical).to be_an_instance_of(Array)
    end

    it '#temporal' do
      expect(@p.temporal).to be_an_instance_of(Hash)
    end

    it '#access' do
      expect(@p.access).to be_an_instance_of(String)
    end

    it '#file' do
      expect(@p.file).to be_an_instance_of(Array)
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String)
    end

    it '#metadata' do
      expect(@p.metadata).to be_an_instance_of(Hash)
    end

  end

end