require 'spec_helper'

describe 'Journal' do

  it '#new' do
    p = Puree::Journal.new
    expect(p).to be_an_instance_of Puree::Journal
  end

  describe 'data retrieval' do
    before(:all) do
      request :journal
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#issn' do
      expect(@p.issn).to be_an_instance_of(String)
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

    it '#publisher' do
      expect(@p.publisher).to be_an_instance_of(String)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  describe 'data retrieval from file' do
    before(:all) do
      request :journal

      @filename = "#{ENV['PURE_FILE_PATH']}journal.#{@uuid}.xml"
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