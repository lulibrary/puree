require 'spec_helper'

describe 'Open API' do

  describe 'dataset retrieval' do
    before(:all) do
      resource = :dataset
      request_open resource
    end

    it '#metadata' do
      expect(@p.created).not_to be_empty
    end
  end

end