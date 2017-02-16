require 'spec_helper'

describe 'Publication' do

  it '#new' do
    p = Puree::Extractor::Publication.new base_url: ENV['PURE_BASE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Publication
  end

  before(:all) do
    request :publication
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Publication
    end

    it '#category' do
      expect(@p.category).to be_an_instance_of(String)
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

    it '#event' do
      expect(@p.event).to be_an_instance_of(Hash)
    end

    it '#file' do
      expect(@p.file).to be_an_instance_of(Array)
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
    end

    it '#modified' do
      expect(@p.modified).to be_an_instance_of(String)
    end

    it '#organisation' do
      expect(@p.organisation).to be_an_instance_of(Array)
    end

    it '#page' do
      expect(@p.page).to be_an_instance_of(String)
    end

    it '#person' do
      expect(@p.person).to be_an_instance_of(Hash)
    end

    it '#status' do
      expect(@p.status).to be_an_instance_of(Array)
    end

    it '#subtitle' do
      expect(@p.subtitle).to be_an_instance_of(String)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end

  end

end