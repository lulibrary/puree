require 'spec_helper'

describe 'Download' do

  before(:all) do

  end

  it '#new' do
    p = Puree::Extractor::Download.new config
    expect(p).to be_a Puree::Extractor::Download
  end

  describe 'data retrieval' do
    before(:all) do
      @p = Puree::Extractor::Download.new config
      @metadata = @p.find resource: :dataset,
                          limit:    10
    end

    it '#find' do
      expect(@metadata).to all( be_a Puree::Model::DownloadHeader )
    end

    it '#find' do
      expect(@metadata).not_to be_empty
    end

  end

end