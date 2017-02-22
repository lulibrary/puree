require 'spec_helper'

describe 'Event' do

  it '#new' do
    p = Puree::Extractor::Event.new url: ENV['PURE_URL']
    expect(p).to be_an_instance_of Puree::Extractor::Event
  end

  before(:all) do
    request :event
  end

  describe 'data retrieval' do

    header

    it 'data structure' do
      expect(@p).to be_a Puree::Model::Event
    end

    it '#city' do
      expect(@p.city).to be_an_instance_of(String) if @p.city
    end

    it '#country' do
      expect(@p.country).to be_an_instance_of(String) if @p.country
    end

    it '#date' do
      expect(@p.date).to be_an_instance_of(Puree::Model::TemporalRange) if @p.date
    end

    it '#description' do
      expect(@p.description).to be_an_instance_of(String) if @p.description
    end

    it '#location' do
      expect(@p.location).to be_an_instance_of(String) if @p.location
    end

    it '#title' do
      expect(@p.title).to be_an_instance_of(String) if @p.title
    end

    it '#type' do
      expect(@p.type).to be_an_instance_of(String) if @p.type
    end

  end

end