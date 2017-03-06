require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Extractor::Dataset.new config
    expect(p).to be_a Puree::Extractor::Dataset
  end

  before(:all) do
    request :dataset
  end

  describe 'data retrieval' do

    resource_header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Dataset
    end

    it '#access' do
      expect(@p.access).to be_a String if @p.access
    end

    it '#associated' do
      expect(@p.associated).to all( be_a Puree::Model::RelatedContentHeader )
    end

    it '#available' do
      expect(@p.available).to be_a Time if @p.available
    end

    it '#description' do
      expect(@p.description).to be_a String if @p.description
    end

    it '#doi' do
      expect(@p.doi).to be_a String if @p.doi
    end

    it '#files' do
      expect(@p.files).to all( be_a Puree::Model::File )
    end

    it '#keywords' do
      expect(@p.keywords).to all( be_a String )
    end

    it '#legal_conditions' do
      expect(@p.legal_conditions).to all( be_a Puree::Model::LegalCondition )
    end

    it '#links' do
      expect(@p.links).to all( be_a Puree::Model::Link )
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

    it '#production' do
      expect(@p.production).to be_a Puree::Model::TemporalRange if @p.production
    end

    it '#projects' do
      expect(@p.projects).to all( be_a Puree::Model::RelatedContentHeader )
    end

    it '#publications' do
      expect(@p.publications).to all( be_a Puree::Model::RelatedContentHeader )
    end

    it '#publisher' do
      expect(@p.publisher).to be_a String if @p.publisher
    end

    it '#spatial_places' do
      expect(@p.spatial_places).to all( be_a String ) if @p.spatial_places
    end

    it '#spatial_point' do
      expect(@p.spatial_point).to be_a Puree::Model::SpatialPoint if @p.spatial_point
    end

    it '#temporal' do
      expect(@p.temporal).to be_a Puree::Model::TemporalRange if @p.temporal
    end

    it '#title' do
      expect(@p.title).to be_a String if @p.title
    end

  end

end