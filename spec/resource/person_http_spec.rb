require 'spec_helper'

describe 'Person' do

  it '#new' do
    p = Puree::Extractor::Person.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Person
  end

  before(:all) do
    request :person
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Person
    end

    it '#affiliation' do
      expect(@p.affiliation).to be_an_instance_of(Array)
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

    it '#image' do
      expect(@p.image).to be_an_instance_of(Array)
    end

    it '#keyword' do
      expect(@p.keyword).to be_an_instance_of(Array)
    end

    it '#locale' do
      expect(@p.locale).to be_an_instance_of(String)
    end

    it '#modified' do
      expect(@p.modified).to be_an_instance_of(String)
    end

    it '#name' do
      expect(@p.name).to be_an_instance_of(Hash)
    end

    it '#orcid' do
      expect(@p.orcid).to be_an_instance_of(String)
    end

    it '#uuid' do
      expect(@p.uuid).to be_an_instance_of(String)
    end

  end

end