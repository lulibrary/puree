require 'spec_helper'

describe 'Organisation' do

  it '#new' do
    p = Puree::Extractor::Organisation.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Organisation
  end

  before(:all) do
    request :organisation
  end

  describe 'data retrieval' do

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Organisation
    end

    it '#address' do
      expect(@p.address).to be_an_instance_of(Array) if @p.address
    end

    it '#name' do
      expect(@p.name).to be_an_instance_of(String) if @p.name
    end

    it '#organisations' do
      expect(@p.organisations).to be_an_instance_of(Array) if @p.organisations
    end

    it '#parent' do
      expect(@p.parent).to be_an_instance_of(Puree::OrganisationHeader) if @p.parent
    end

    it '#phone_numbers' do
      expect(@p.phone_numbers).to be_an_instance_of(Array) if @p.phone_numbers
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String) if @p.type
    end

    it '#urls' do
      expect(@p.urls).to be_an_instance_of(Array) if @p.urls
    end

  end

end