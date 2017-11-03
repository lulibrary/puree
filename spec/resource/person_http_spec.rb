require 'spec_helper'

describe 'Person' do

  it '#new' do
    p = Puree::Extractor::Person.new config
    expect(p).to be_a Puree::Extractor::Person
  end

  before(:all) do
    request :person
  end

  describe 'data retrieval' do

    resource_header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Person
    end

    it '#affiliations' do
      expect(@p.affiliations).to all( be_a Puree::Model::OrganisationHeader )
    end

    it '#email_addresses' do
      expect(@p.email_addresses).to all( be_a String )
    end

    it '#employee_id' do
      expect(@p.employee_id).to be_a String if @p.employee_id
    end

    it '#hesa_id' do
      expect(@p.hesa_id).to be_a String if @p.hesa_id
    end

    it '#image_urls' do
      expect(@p.image_urls).to all( be_a String )
    end

    it '#keywords' do
      expect(@p.keywords).to all( be_a String )
    end

    it '#name' do
      expect(@p.name).to be_a Puree::Model::PersonName if @p.name
    end

    it '#orcid' do
      expect(@p.orcid).to be_a String if @p.orcid
    end

    it '#scopus_id' do
      expect(@p.scopus_id).to be_a String if @p.scopus_id
    end

  end

end