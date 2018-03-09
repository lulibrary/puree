require 'spec_helper'

describe 'Publication' do

  it '#new' do
    p = Puree::Extractor::Publication.new config
    expect(p).to be_a Puree::Extractor::Publication
  end

  before(:all) do
    request :publication
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Publication
    end

    it '#associated' do
      expect(@p.associated).to all( be_a Puree::Model::RelatedContentHeader )
    end

    it '#bibliographical_note' do
      expect(@p.bibliographical_note).to be_a String if @p.bibliographical_note
    end

    it '#category' do
      expect(@p.category).to be_a String if @p.category
    end

    it '#description' do
      expect(@p.description).to be_a String if @p.description
    end

    it '#doi' do
      expect(@p.doi).to be_a String if @p.doi
    end

    it '#dois' do
      expect(@p.dois).to all( be_a String )
    end

    it '#external_organisations' do
      expect(@p.external_organisations).to all( be_a Puree::Model::ExternalOrganisationHeader )
    end

    it '#files' do
      expect(@p.files).to all( be_a Puree::Model::File )
    end

    it '#keywords' do
      expect(@p.keywords).to all( be_a String )
    end

    it '#language' do
      expect(@p.language).to be_a String if @p.language
    end

    it '#links' do
      expect(@p.links).to all( be_a String )
    end

    it '#organisations' do
      expect(@p.organisations).to all( be_a Puree::Model::OrganisationHeader )
    end

    it '#owner' do
      expect(@p.owner).to be_a Puree::Model::OrganisationHeader if @p.owner
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

    it '#publication_place' do
      expect(@p.publication_place).to be_a String if @p.publication_place
    end

    it '#publisher' do
      expect(@p.publisher).to be_a String if @p.publisher
    end

    it '#scopus_id' do
      expect(@p.scopus_id).to be_a String if @p.scopus_id
    end

    it '#statuses' do
      expect(@p.statuses).to all( be_a Puree::Model::PublicationStatus )
    end

    it '#subtitle' do
      expect(@p.subtitle).to be_a String if @p.subtitle
    end

    it '#title' do
      expect(@p.title).to be_a String if @p.title
    end

    it '#translated_subtitle' do
      expect(@p.translated_subtitle).to be_a String if @p.translated_subtitle
    end

    it '#translated_title' do
      expect(@p.translated_title).to be_a String if @p.translated_title
    end

    it '#type' do
      expect(@p.type).to be_a String if @p.type
    end

    it '#workflow_state' do
      expect(@p.workflow_state).to be_a String if @p.workflow_state
    end

  end

end