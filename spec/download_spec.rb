require 'spec_helper'

describe 'Download' do

  it '#new' do
    p = Puree::Extractor::Download.new base_url: ENV['PURE_BASE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Download
  end

  describe 'data retrieval' do
    before(:all) do
      @p = Puree::Extractor::Download.new(base_url: ENV['PURE_BASE_URL'])
      @p.basic_auth username: ENV['PURE_USERNAME'],
                    password: ENV['PURE_PASSWORD']
      @metadata = @p.find resource: :dataset,
                          limit:    10
    end

    it '#find' do
      expect(@metadata).to be_an_instance_of(Array)
    end

    it '#find' do
      expect(@metadata).not_to be_empty
    end

  end

end