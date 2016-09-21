require 'spec_helper'

describe 'Publisher' do

  def request
    base_url = ENV['PURE_BASE_URL']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    @uuid = ENV['PURE_PUBLISHER_UUID']
    @p = Puree::Publisher.new(base_url: base_url,
                                username: username,
                                password: password,
                                basic_auth: true)
    @metadata = @p.find uuid: @uuid
  end

  it '#new' do
    p = Puree::Publisher.new
    expect(p).to be_an_instance_of Puree::Publisher
  end

  describe 'data retrieval' do
    before(:all) do
      request
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#metadata' do
      expect(@p.metadata).to be_an_instance_of(Hash)
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
      request

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

  end

end