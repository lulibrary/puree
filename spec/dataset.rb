require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Dataset.new
    expect(p).to be_an_instance_of Puree::Dataset
  end

  describe 'data retrieval' do
    before(:all) do
      base_url = ENV['PURE_BASE_URL']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      uuid = ENV['PURE_DATASET_UUID']
      @p = Puree::Dataset.new(base_url: base_url,
                              username: username,
                              password: password,
                              basic_auth: true)
      @metadata = @p.find uuid: uuid
    end

    it '@metadata' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#access' do
      expect(@metadata['access']).to be_an_instance_of(String)
    end

    it '#associated' do
      expect(@metadata['associated']).to be_an_instance_of(Array)
    end

    it '#available' do
      expect(@metadata['available']).to be_an_instance_of(Hash)
    end

    it '#created' do
      expect(@metadata['created']).to be_an_instance_of(String)
    end

    it '#description' do
      expect(@metadata['description']).to be_an_instance_of(String)
    end

    it '#doi' do
      expect(@metadata['doi']).to be_an_instance_of(String)
    end

    it '#file' do
      expect(@metadata['file']).to be_an_instance_of(Array)
    end

    it '#keyword' do
      expect(@metadata['keyword']).to be_an_instance_of(Array)
    end

    it '#link' do
      expect(@metadata['link']).to be_an_instance_of(Array)
    end

    it '#modified' do
      expect(@metadata['modified']).to be_an_instance_of(String)
    end

    it '#person' do
      expect(@metadata['person']).to be_an_instance_of(Hash)
    end

    it '#production' do
      expect(@metadata['production']).to be_an_instance_of(Hash)
    end

    it '#project' do
      expect(@metadata['project']).to be_an_instance_of(Array)
    end

    it '#publication' do
      expect(@metadata['publication']).to be_an_instance_of(Array)
    end

    it '#publisher' do
      expect(@metadata['publisher']).to be_an_instance_of(String)
    end

    it '#spatial' do
      expect(@metadata['spatial']).to be_an_instance_of(Array)
    end

    it '#temporal' do
      expect(@metadata['temporal']).to be_an_instance_of(Hash)
    end

    it '#title' do
      expect(@metadata['title']).to be_an_instance_of(String)
    end


  end

end