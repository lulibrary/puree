require 'spec_helper'

describe 'Publication' do

  it '#new' do
    p = Puree::Publication.new
    expect(p).to be_an_instance_of Puree::Publication
  end

  describe 'data retrieval' do
    before(:all) do
      request :publication
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#category' do
      expect(@p.category).to be_an_instance_of(String)
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

    it '#event' do
      expect(@p.event).to be_an_instance_of(Hash)
    end

    it '#file' do
      expect(@p.file).to be_an_instance_of(Array)
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
    end

    it '#metadata' do
      expect(@p.metadata).to be_an_instance_of(Hash)
    end

    it '#metadata' do
      expect(@p.metadata).not_to be_empty
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

  describe 'data retrieval from file' do
    before(:all) do
      request :publication

      @filename = "#{ENV['PURE_FILE_PATH']}publication.#{@uuid}.xml"
      File.write(@filename, @p.response.body)

      @metadata = @p.set_content File.read(@filename)
    end

    it '#set_content' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#metadata' do
      expect(@p.metadata).to be_an_instance_of(Hash)
    end

    it '#metadata' do
      expect(@p.metadata).not_to be_empty
    end

    after(:all) do
      File.delete @filename if File.exists? @filename
    end

  end

end