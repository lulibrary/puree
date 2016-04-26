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

    it '#titles' do
      expect(@p.titles).to be_an_instance_of(Array)
    end

    it '#keywords' do
      expect(@p.keywords).to be_an_instance_of(Array)
    end

    it '#descriptions' do
      expect(@p.descriptions).to be_an_instance_of(Array)
    end

    it '#people' do
      expect(@p.people).to be_an_instance_of(Hash)
    end

    it '#publications' do
      expect(@p.publications).to be_an_instance_of(Array)
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

    it '#files' do
      expect(@p.files).to be_an_instance_of(Array)
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String)
    end

    it '#all' do
      expect(@p.all).to be_an_instance_of(Hash)
    end

  end

end