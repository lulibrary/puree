require 'spec_helper'

def new
  @p = Puree::Extractor::Collection.new resource: @resource_type,
                                        config: config
end

def go resource_type
  @resource_type = resource_type
  new
  fetch
end

def fetch
  count = @p.count
  (0..count-1).each do |i|
    resource = @p.find limit: 1,
                       offset: i
    expect(resource[0]).to be_a resource_class
    puts "#{i+1} of #{count} #{@resource_type}s"
    sleep 1
    system 'clear'
  end
end

def resource_class
  str = "Puree::Model::#{@resource_type.to_s.capitalize}"
  Object.const_get(str)
end

describe 'dataset' do
  it 'get all, one at a time' do
    go :dataset
  end
end

describe 'event' do
  it 'get all, one at a time' do
    go :event
  end
end

describe 'journal' do
  it 'get all, one at a time' do
    go :journal
  end
end

describe 'organisation' do
  it 'get all, one at a time' do
    go :organisation
  end
end

describe 'person' do
  it 'get all, one at a time' do
    go :person
  end
end

describe 'project' do
  it 'get all, one at a time' do
    go :project
  end
end

describe 'publication' do
  it 'get all, one at a time' do
    go :publication
  end
end

describe 'publisher' do
  it 'get all, one at a time' do
    go :publisher
  end
end
