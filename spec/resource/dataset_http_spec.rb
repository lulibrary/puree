require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Extractor::Dataset.new base_url: ENV['PURE_BASE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Dataset
  end

  before(:all) do
    request :dataset
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Dataset
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

    it '#created' do
      expect(@p.created).not_to be_empty
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

    it '#keyword' do
      expect(@p.keyword).to be_an_instance_of(Array)
    end

    it '#link' do
      expect(@p.link).to be_an_instance_of(Array)
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
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

    it '#spatial' do
      expect(@p.spatial).to be_an_instance_of(Array)
    end

    it '#spatial_point' do
      expect(@p.spatial_point).to be_an_instance_of(Hash)
    end

    it '#temporal' do
      expect(@p.temporal).to be_an_instance_of(Hash)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  # describe 'data retrieval from file' do
  #   before(:all) do
  #     @filename = "#{ENV['PURE_FILE_PATH']}dataset.#{@uuid}.xml"
  #     File.write(@filename, @extractor.response.body)
  #     @p = @extractor.set_content File.read(@filename)
  #   end
  #
  #   it '#created' do
  #     expect(@p.created).not_to be_empty
  #   end
  #
  #   after(:all) do
  #     File.delete @filename if File.exists? @filename
  #   end
  #
  # end

end