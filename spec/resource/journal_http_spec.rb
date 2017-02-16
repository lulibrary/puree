require 'spec_helper'

describe 'Journal' do

  it '#new' do
    p = Puree::Extractor::Journal.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Journal
  end

  before(:all) do
    request :journal
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Journal
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#created' do
      expect(@p.created).not_to be_empty
    end

    it '#issn' do
      expect(@p.issn).to be_an_instance_of(String)
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
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

end