require 'spec_helper'

describe 'Organisation' do

  it '#new' do
    p = Puree::Organisation.new
    expect(p).to be_an_instance_of Puree::Organisation
  end

  describe 'data retrieval' do
    before(:all) do
      request :organisation
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#address' do
      expect(@p.address).to be_an_instance_of(Array)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#email' do
      expect(@p.email).to be_an_instance_of(Array)
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
      expect(@p.name).to be_an_instance_of(String)
    end

    it '#organisation' do
      expect(@p.organisation).to be_an_instance_of(Array)
    end

    it '#parent' do
      expect(@p.parent).to be_an_instance_of(Hash)
    end

    it '#phone' do
      expect(@p.phone).to be_an_instance_of(Array)
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String)
    end

    it '#url' do
      expect(@p.url).to be_an_instance_of(Array)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  describe 'data retrieval from file' do
    before(:all) do
      request :organisation

      filename = "#{ENV['PURE_FILE_PATH']}organisation.#{@uuid}.xml"
      File.write(filename, @p.response.body)

      @metadata = @p.set_content File.read(filename)
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

  end

end