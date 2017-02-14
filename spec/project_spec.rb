require 'spec_helper'

describe 'Project' do

  it '#new' do
    p = Puree::Project.new
    expect(p).to be_an_instance_of Puree::Project
  end

  describe 'data retrieval' do
    before(:all) do
      request :project
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#acronym' do
      expect(@p.acronym).to be_an_instance_of(String)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String)
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

    it '#owner' do
      expect(@p.owner).to be_an_instance_of(Hash)
    end

    it '#person' do
      expect(@p.person).to be_an_instance_of(Hash)
    end

    it '#status' do
      expect(@p.status).to be_an_instance_of(String)
    end

    it '#temporal' do
      expect(@p.temporal).to be_an_instance_of(Hash)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String)
    end

    it '#url' do
      expect(@p.url).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  describe 'data retrieval from file' do
    before(:all) do
      request :project

      @filename = "#{ENV['PURE_FILE_PATH']}project.#{@uuid}.xml"
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