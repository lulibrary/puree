require 'spec_helper'

describe 'Publisher' do

  it '#new' do
    p = Puree::Extractor::Publisher.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Publisher
  end

  before(:all) do
    request :publisher
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Publisher
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#created' do
      expect(@p.created).not_to be_empty
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
    end

    it '#modified' do
      expect(@p.modified).to be_an_instance_of(String)
    end

    it '#name' do
      expect(@p.name).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end

  end

end