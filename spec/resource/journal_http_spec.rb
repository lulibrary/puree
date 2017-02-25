require 'spec_helper'

describe 'Journal' do

  it '#new' do
    p = Puree::Extractor::Journal.new url: ENV['PURE_URL']
    expect(p).to be_a Puree::Extractor::Journal
  end

  before(:all) do
    request :journal
  end

  describe 'data retrieval' do

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Journal
    end

    it '#issn' do
      expect(@p.issn).to be_a String if @p.issn
    end

    it '#publisher' do
      expect(@p.publisher).to be_a String if @p.publisher
    end

    it '#title' do
      expect(@p.title).to be_a String if @p.title
    end

  end

end