require 'spec_helper'

describe 'Funding' do

  it '#new' do
    q = Puree::Query::Funding.new config
    expect(q).to be_a Puree::Query::Funding
  end

  describe 'project data retrieval' do
    before(:all) do
      request :project
      @project_uuid = @p.uuid
      @q = Puree::Query::Funding.new config
    end

    it '#project_funders' do
      funders = @q.project_funders uuid: @project_uuid
      expect(funders).to all( be_a Puree::Model::ExternalOrganisation )
    end

    it '#publication_funders' do
      funders = @q.publication_funders uuid: @project_uuid
      expect(funders).to all( be_a Puree::Model::ExternalOrganisation )
    end

  end

end