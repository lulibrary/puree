require 'spec_helper'

describe 'Publication' do

  it '#new' do
    p = Puree::Extractor::Publication.new url: ENV['PURE_URL']
    expect(p).to be_a Puree::Extractor::Publication
  end

  before(:all) do
    request :publication
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Publication
    end

    it '#category' do
      expect(@p.category).to be_a String
    end

    it '#description' do
      expect(@p.description).to be_a String
    end

    it '#doi' do
      expect(@p.doi).to be_a String
    end

    it '#event' do
      expect(@p.event).to be_a Puree::Model::EventHeader
    end

    it '#files' do
      expect(@p.files).to all( be_a Puree::Model::File )
    end

    it '#organisations' do
      expect(@p.organisations).to all( be_a Puree::Model::OrganisationHeader )
    end

    it '#page' do
      expect(@p.page).to be_a Fixnum
    end

    it '#persons_internal' do
      expect(@p.persons_internal).to all( be_a Puree::Model::EndeavourPerson )
    end

    it '#persons_external' do
      expect(@p.persons_external).to all( be_a Puree::Model::EndeavourPerson )
    end

    it '#persons_other' do
      expect(@p.persons_other).to all( be_a Puree::Model::EndeavourPerson )
    end

    it '#statuses' do
      expect(@p.statuses).to all( be_a Puree::Model::PublicationStatus )
    end

    it '#subtitle' do
      expect(@p.subtitle).to be_a String
    end

    it '#title' do
      expect(@p.title).to be_a String
    end

    it '#type' do
      expect(@p.type).to be_a String
    end

  end

end