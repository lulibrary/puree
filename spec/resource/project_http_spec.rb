require 'spec_helper'

describe 'Project' do

  it '#new' do
    p = Puree::Extractor::Project.new config
    expect(p).to be_a Puree::Extractor::Project
  end

  before(:all) do
    request :project
  end

  describe 'data retrieval' do

    resource_header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Project
    end

    it '#acronym' do
      expect(@p.acronym).to be_a String if @p.acronym
    end

    it '#description' do
      expect(@p.description).to be_a String if @p.description
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

    it '#status' do
      expect(@p.status).to be_a String if @p.status
    end

    it '#temporal_actual' do
      expect(@p.temporal_actual).to be_a Puree::Model::TemporalRange if @p.temporal_actual
    end

    it '#temporal_expected' do
      expect(@p.temporal_expected).to be_a Puree::Model::TemporalRange if @p.temporal_expected
    end

    it '#title' do
      expect(@p.title).to be_a String if @p.title
    end

    it '#type' do
      expect(@p.type).to be_a String if @p.type
    end

    it '#url' do
      expect(@p.url).to be_a String if @p.url
    end

  end

end