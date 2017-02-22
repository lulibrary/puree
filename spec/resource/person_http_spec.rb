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

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Person
    end

    it '#affiliations' do
      expect(@p.affiliations).to be_an_instance_of(Array)
    end

    it '#email_addresses' do
      expect(@p.email_addresses).to be_an_instance_of(Array)
    end

    it '#image_urls' do
      expect(@p.image_urls).to be_an_instance_of(Array)
    end

    it '#keywords' do
      expect(@p.keywords).to be_an_instance_of(Array)
    end

    it '#name' do
      expect(@p.name).to be_an_instance_of(Puree::Model::PersonName)
    end

    it '#orcid' do
      expect(@p.orcid).to be_an_instance_of(String)
    end

  end

end