require 'spec_helper'

describe 'Project' do

  it '#new' do
    p = Puree::Extractor::Project.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Project
  end

  before(:all) do
    request :project
  end

  describe 'data retrieval' do

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Project
    end

    it '#acronym' do
      expect(@p.acronym).to be_an_instance_of(String)
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String)
    end

    it '#organisations' do
      expect(@p.organisations).to be_an_instance_of(Array)
    end

    it '#owner' do
      expect(@p.owner).to be_an_instance_of(Puree::Model::OrganisationHeader)
    end

    it '#persons_internal' do
      expect(@p.persons_internal).to be_an_instance_of(Array)
    end

    it '#persons_external' do
      expect(@p.persons_external).to be_an_instance_of(Array)
    end

    it '#persons_other' do
      expect(@p.persons_other).to be_an_instance_of(Array)
    end

    it '#statuses' do
      expect(@p.status).to be_an_instance_of(String)
    end

    it '#temporal_actual' do
      expect(@p.temporal_actual).to be_an_instance_of(Puree::Model::TemporalRange)
    end

    it '#temporal_expected' do
      expect(@p.temporal_expected).to be_an_instance_of(Puree::Model::TemporalRange)
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String)
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String)
    end

    it '#url' do
      expect(@p.url).to be_an_instance_of(String)
    end

  end

end