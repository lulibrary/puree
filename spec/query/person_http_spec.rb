require 'spec_helper'

describe 'Person' do

  it '#new' do
    q = Puree::Query::Person.new config
    expect(q).to be_a Puree::Query::Person
  end

  before(:all) do
    request :person
    @person_uuid = @p.uuid
    @q = Puree::Query::Person.new config
  end

  describe 'data retrieval' do
    it '#publication_count' do
      publication_count = @q.publication_count uuid: @person_uuid
      expect(publication_count).to be_a Fixnum if publication_count
    end

    it '#publications' do
      publications = @q.publications uuid: @person_uuid,
                                     limit: 3
      expect(publications).to all( be_a Puree::Model::Publication )
    end

    it '#publications_offset' do
      publications = @q.publications uuid: @person_uuid,
                                     limit: 3,
                                     offset: 1
      expect(publications).to all( be_a Puree::Model::Publication )
    end

    it '#publications_published_start' do
      publications = @q.publications uuid: @person_uuid,
                                     limit: 3,
                                     published_start: '2017-01-01'
      expect(publications).to all( be_a Puree::Model::Publication )
    end

    it '#publications_published_start_published_end' do
      publications = @q.publications uuid: @person_uuid,
                                     limit: 3,
                                     published_start: '2017-01-01',
                                     published_end: '2017-12-31'
      expect(publications).to all( be_a Puree::Model::Publication )
    end

  end

end