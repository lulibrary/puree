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

  end

end