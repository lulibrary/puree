require 'spec_helper'

describe 'Publisher' do

  it '#new' do
    p = Puree::Publisher.new
    expect(p).to be_an_instance_of Puree::Publisher
  end

  describe 'data retrieval' do
    before(:all) do
      request :publisher
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
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

    # Adds no value as value is Publisher
    # it '#type' do
    #   expect(@p.type).to be_an_instance_of(String)
    # end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end
  end

  describe 'data retrieval from file' do
    before(:all) do
      request :publisher

      filename = "#{ENV['PURE_FILE_PATH']}publisher.#{@uuid}.xml"
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