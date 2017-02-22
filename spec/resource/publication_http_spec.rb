require 'spec_helper'

describe 'Publication' do

  it '#new' do
    p = Puree::Extractor::Publication.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Publication
  end

  before(:all) do
    request :publication
  end

  describe 'data retrieval' do

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Publication
    end

    it '#category' do
      expect(@p.category).to be_an_instance_of(String) if @p.category
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String) if @p.description
    end

    it '#doi' do
      expect(@p.doi).to be_an_instance_of(String) if @p.doi
    end

    it '#event' do
      expect(@p.event).to be_an_instance_of(Puree::Model::EventHeader) if @p.event
    end

    it '#files' do
      expect(@p.files).to be_an_instance_of(Array) if @p.files
    end

    it '#organisations' do
      expect(@p.organisations).to be_an_instance_of(Array) if @p.organisations
    end

    it '#page' do
      expect(@p.page).to be_an_instance_of(Fixnum) if @p.page
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

    it '#statuses' do
      expect(@p.statuses).to be_an_instance_of(Array) if @p.statuses
    end

    it '#subtitle' do
      expect(@p.subtitle).to be_an_instance_of(String) if @p.subtitle
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String) if @p.title
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String) if @p.type
    end

  end

end