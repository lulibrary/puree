require 'spec_helper'

describe 'Collection of datasets' do

  def new
    @p = Puree::Extractor::Collection.new resource: :dataset,
                                          config:   config
  end

  def setup
    new
  end

  it '#new' do
    new
    expect(@p).to be_a(Puree::Extractor::Collection)
  end

  describe 'data retrieval' do
    before(:all) do
      setup
      @metadata = @p.find limit: 5
    end

    it 'collection' do
      expect(@metadata).to be_a(Array)
    end

  end

  describe 'data retrieval instance' do
    before(:all) do
      setup
      @metadata = @p.find limit: 5
    end

    it 'collection' do
      expect(@metadata).to be_a(Array)
    end

    it 'collection item' do
      expect(@metadata).to all( be_a Puree::Model::Dataset )
    end

  end

  describe 'data retrieval count' do
    before(:all) do
      setup
      @p.find limit: 0
    end

    it '#count' do
      expect(@p.count).to be_a(Fixnum)
    end

  end

  it '#random_resource' do
    setup
    metadata = @p.random_resource
    expect(metadata).to be_a Puree::Model::Dataset
  end

end