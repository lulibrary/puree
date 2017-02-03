require 'spec_helper'

describe 'Journal' do

  def request
    base_url = ENV['PURE_BASE_URL']
    username = ENV['PURE_USERNAME']
    password = ENV['PURE_PASSWORD']
    @uuid = ENV['PURE_JOURNAL_UUID']
    @p = Puree::Journal.new(base_url: base_url,
                          username: username,
                          password: password,
                          basic_auth: true)
    @metadata = @p.find uuid: @uuid
  end

  it '#new' do
    p = Puree::Journal.new
    expect(p).to be_an_instance_of Puree::Journal
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
      request

      filename = "#{ENV['PURE_FILE_PATH']}journal.#{@uuid}.xml"
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