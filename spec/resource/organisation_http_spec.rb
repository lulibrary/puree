require 'spec_helper'

describe 'Organisation' do

  it '#new' do
    p = Puree::Extractor::Organisation.new url: ENV['PURE_URL']
    expect(p).to be_a Puree::Extractor::Organisation
  end

  before(:all) do
    request :organisation
  end

  describe 'data retrieval' do

    resource_header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Organisation
    end

    it '#address' do
      expect(@p.address).to all( be_a Puree::Model::Address )
    end

    it '#name' do
      expect(@p.name).to be_a String if @p.name
    end

    it '#organisations' do
      expect(@p.organisations).to all( be_a Puree::Model::OrganisationHeader )
    end

    it '#parent' do
      expect(@p.parent).to be_a Puree::Model::OrganisationHeader if @p.parent
    end

    it '#phone_numbers' do
      expect(@p.phone_numbers).to all( be_a String )
    end

    it '#type' do
      expect(@p.type).to be_a String if @p.type
    end

    it '#urls' do
      expect(@p.urls).to all( be_a String )
    end

  end

end