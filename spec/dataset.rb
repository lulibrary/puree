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
      @p = Puree::Dataset.new(endpoint: endpoint,
                              username: username,
                              password: password)
      @p.find uuid: uuid
    end

    it '#access' do
      expect(@p.access).to be_an_instance_of(String)
    end

    it '#associated' do
      expect(@p.associated).to be_an_instance_of(Array)
    end

    it '#available' do
      expect(@p.available).to be_an_instance_of(Hash)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String)
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String)
    end

    it '#file' do
      expect(@p.file).to be_an_instance_of(Array)
    end

    it '#geographical' do
      expect(@p.geographical).to be_an_instance_of(Array)
    end

    it '#keyword' do
      expect(@p.keyword).to be_an_instance_of(Array)
    end

    it '#link' do
      expect(@p.link).to be_an_instance_of(Array)
    end

    it '#metadata' do
      expect(@p.metadata).to be_an_instance_of(Hash)
    end

    it '#modified' do
      expect(@p.modified).to be_an_instance_of(String)
    end

    it '#person' do
      expect(@p.person).to be_an_instance_of(Hash)
    end

    it '#production' do
      expect(@p.production).to be_an_instance_of(Hash)
    end

    it '#project' do
      expect(@p.project).to be_an_instance_of(Array)
    end

    it '#publication' do
      expect(@p.publication).to be_an_instance_of(Array)
    end

    it '#publisher' do
      expect(@p.publisher).to be_an_instance_of(String)
    end

    it '#temporal' do
      expect(@p.temporal).to be_an_instance_of(Hash)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end


  end

end