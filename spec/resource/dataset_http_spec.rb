require 'spec_helper'

describe 'Dataset' do

  it '#new' do
    p = Puree::Extractor::Dataset.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Dataset
  end

  before(:all) do
    request :dataset
  end

  describe 'data retrieval' do

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Dataset
    end

    it '#access' do
      expect(@p.access).to be_an_instance_of(String) if @p.access
    end

    it '#associated' do
      expect(@p.associated).to be_an_instance_of(Array) if @p.associated
    end

    it '#available' do
      expect(@p.available).to be_an_instance_of(Time) if @p.available
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String) if @p.description
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String) if @p.doi
    end

    it '#files' do
      expect(@p.files).to be_an_instance_of(Array) if @p.files
    end

    it '#keywords' do
      expect(@p.keywords).to be_an_instance_of(Array) if @p.keywords
    end

    it '#legal_conditions' do
      expect(@p.legal_conditions).to be_an_instance_of(Array) if @p.legal_conditions
    end

    it '#links' do
      expect(@p.links).to be_an_instance_of(Array) if @p.links
    end

    it '#persons_internal' do
      expect(@p.persons_internal).to be_an_instance_of(Array) if @p.persons_internal
    end

    it '#persons_external' do
      expect(@p.persons_external).to be_an_instance_of(Array) if @p.persons_external
    end

    it '#persons_other' do
      expect(@p.persons_other).to be_an_instance_of(Array) if @p.persons_other
    end

    it '#production' do
      expect(@p.production).to be_an_instance_of(Puree::Model::TemporalRange) if @p.production
    end

    it '#projects' do
      expect(@p.projects).to be_an_instance_of(Array) if @p.projects
    end

    it '#publications' do
      expect(@p.publications).to be_an_instance_of(Array) if @p.publications
    end

    it '#publisher' do
      expect(@p.publisher).to be_an_instance_of(String) if @p.publisher
    end

    it '#spatial_places' do
      expect(@p.spatial_places).to be_an_instance_of(Array) if @p.spatial_places
    end

    it '#spatial_point' do
      expect(@p.spatial_point).to be_an_instance_of(Puree::Model::SpatialPoint) if @p.spatial_point
    end

    it '#temporal' do
      expect(@p.temporal).to be_an_instance_of(Puree::Model::TemporalRange) if @p.temporal
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String) if @p.title
    end

  end

end