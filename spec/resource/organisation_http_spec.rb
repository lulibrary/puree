require 'spec_helper'

describe 'Organisation' do

  it '#new' do
    p = Puree::Extractor::Organisation.new base_url: ENV['PURE_BASE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Organisation
  end

  before(:all) do
    request :organisation
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Organisation
    end

    it '#address' do
      expect(@p.address).to be_an_instance_of(Array)
    end

    it '#created' do
      expect(@p.created).to be_an_instance_of(String)
    end

    it '#created' do
      expect(@p.created).not_to be_empty
    end

    it '#email' do
      expect(@p.email).to be_an_instance_of(Array)
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

    it '#organisation' do
      expect(@p.organisation).to be_an_instance_of(Array)
    end

    it '#parent' do
      expect(@p.parent).to be_an_instance_of(Hash)
    end

    it '#phone' do
      expect(@p.phone).to be_an_instance_of(Array)
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String)
    end

    it '#url' do
      expect(@p.url).to be_an_instance_of(Array)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end

  end

end