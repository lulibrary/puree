require 'spec_helper'

describe 'Download' do

  it '#new' do
    p = Puree::Download.new
    expect(p).to be_an_instance_of Puree::Download
  end

  describe 'data retrieval' do
    before(:all) do
      base_url = ENV['PURE_BASE_URL']
      username = ENV['PURE_USERNAME']
      password = ENV['PURE_PASSWORD']
      @p = Puree::Download.new(base_url: base_url,
                              username: username,
                              password: password,
                              basic_auth: true)
      @metadata = @p.find resource: :dataset,
                          limit:    10
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Array)
    end

  end

end