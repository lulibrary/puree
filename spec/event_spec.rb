require 'spec_helper'

describe 'Event' do

  def request
    base_url = ENV['PURE_BASE_URL']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    @uuid = ENV['PURE_EVENT_UUID']
    @p = Puree::Event.new(base_url: base_url,
                            username: username,
                            password: password,
                            basic_auth: true)
    @metadata = @p.find uuid: @uuid
  end

  it '#new' do
    p = Puree::Event.new
    expect(p).to be_an_instance_of Puree::Event
  end

  describe 'data retrieval' do
    before(:all) do
      request
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Hash)
    end

    it '#city' do
      expect(@p.city).to be_an_instance_of(String)
    end

    it '#country' do
      expect(@p.country).to be_an_instance_of(String)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#date' do
      expect(@p.date).to be_an_instance_of(Hash)
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String)
    end

    it '#location' do
      expect(@p.location).to be_an_instance_of(String)
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
      request

      filename = "#{ENV['PURE_FILE_PATH']}event.#{@uuid}.xml"
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