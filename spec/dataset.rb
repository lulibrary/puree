require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Dataset.new 'endpoint', 'username', 'password'
    expect(p).to be_an_instance_of Puree::Dataset
  end

  describe 'data retrieval' do
    before(:all) do
      endpoint = ENV['PURE_ENDPOINT']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      uuid = ENV['PURE_DATASET_UUID']
      @p = Puree::Dataset.new endpoint, username, password
      @p.get uuid: uuid
    end

    it 'resource is found' do
      expect(@p.data?).to eq(true)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(Array)
    end

    it '#keywords' do
      expect(@p.keywords).to be_an_instance_of(Array)
    end

    it '#persons' do
      expect(@p.persons).to be_an_instance_of(Hash)
    end

    it '#relatedPublications' do
      expect(@p.relatedPublications).to be_an_instance_of(Array)
    end

    it '#dateMadeAvailable' do
      expect(@p.dateMadeAvailable).to be_an_instance_of(Hash)
    end

    it '#geographicalCoverage' do
      expect(@p.geographicalCoverage).to be_an_instance_of(Array)
    end

    it '#temporalCoverageStartDate' do
      expect(@p.temporalCoverageStartDate).to be_an_instance_of(Hash)
    end

    it '#temporalCoverageEndDate' do
      expect(@p.temporalCoverageEndDate).to be_an_instance_of(Hash)
    end

    it '#openAccessPermission' do
      expect(@p.openAccessPermission).to be_an_instance_of(String)
    end

    it '#documents' do
      expect(@p.documents).to be_an_instance_of(Array)
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String)
    end

    it '#all' do
      expect(@p.all).to be_an_instance_of(Hash)
    end

  end

end