require 'test_xml_extractor_helper'

class TestXMLExtractorResourceCollection < Minitest::Test

  def test_datasets
    client = Puree::API::RESTClient.new config
    response = client.datasets.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.datasets response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Dataset, data.first if !data.empty?
  end

  def test_events
    client = Puree::API::RESTClient.new config
    response = client.events.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.events response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Event, data.first if !data.empty?
  end

  def test_external_organisations
    client = Puree::API::RESTClient.new config
    response = client.external_organisations.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.external_organisations response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::ExternalOrganisation, data.first if !data.empty?
  end

  def test_journals
    client = Puree::API::RESTClient.new config
    response = client.journals.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.journals response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Journal, data.first if !data.empty?
  end

  def test_organisations
    client = Puree::API::RESTClient.new config
    response = client.organisational_units.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.organisational_units response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::OrganisationalUnit, data.first if !data.empty?
  end

  def test_persons
    client = Puree::API::RESTClient.new config
    response = client.persons.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.persons response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Person, data.first if !data.empty?
  end

  def test_projects
    client = Puree::API::RESTClient.new config
    response = client.projects.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.projects response.to_s
    # puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Project, data.first if !data.empty?
  end

end