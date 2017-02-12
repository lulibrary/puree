require 'spec_helper'

describe 'Person' do

  it '#new' do
    p = Puree::Person.new
    expect(p).to be_an_instance_of Puree::Person
  end

  describe 'data retrieval' do
    before(:all) do
      request :person
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#affiliation' do
      expect(@p.affiliation).to be_an_instance_of(Array)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#email' do
      expect(@p.email).to be_an_instance_of(Array)
    end

    it '#image' do
      expect(@p.image).to be_an_instance_of(Array)
    end

    it '#keyword' do
      expect(@p.keyword).to be_an_instance_of(Array)
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

    it '#name' do
      expect(@p.name).to be_an_instance_of(Hash)
    end

    it '#orcid' do
      expect(@p.orcid).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  describe 'data retrieval from file' do
    before(:all) do
      request :person

      @filename = "#{ENV['PURE_FILE_PATH']}person.#{@uuid}.xml"
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