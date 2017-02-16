require 'spec_helper'

describe 'Collection of datasets' do

  def new
    @p = Puree::Extractor::Collection.new resource: :dataset,
                               base_url: ENV['PURE_BASE_URL']
  end

  def setup
    new
    @p.basic_auth username: ENV['PURE_USERNAME'],
                  password: ENV['PURE_PASSWORD']

  end

  it '#new' do
    new
    expect(@p).to be_an_instance_of(Puree::Extractor::Collection)
  end

  describe 'data retrieval' do
    before(:all) do
      setup
      @metadata = @p.find limit: 5
    end

    it 'collection' do
      expect(@metadata).to be_an_instance_of(Array)
    end

  end

  describe 'data retrieval instance' do
    before(:all) do
      setup
      @metadata = @p.find limit: 5
    end

    it 'collection' do
      expect(@metadata).to be_an_instance_of(Array)
    end

    it 'collection item' do
      expect(@metadata[0]).to be_a Puree::Dataset
    end

  end

  describe 'data retrieval count' do
    before(:all) do
      setup
      @p.find limit: 0
    end

    it '#count' do
      expect(@p.count).to be_an_instance_of(Fixnum)
    end

  end

end