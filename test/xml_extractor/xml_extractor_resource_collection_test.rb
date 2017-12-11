require 'test_helper'

class TestXMLExtractorResourceCollection < Minitest::Test

  def test_datasets
    response = client.datasets.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.datasets response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Dataset, data.first if !data.empty?
  end

  def test_events
    response = client.events.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.events response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Event, data.first if !data.empty?
  end

  def test_external_organisations
    response = client.external_organisations.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.external_organisations response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::ExternalOrganisation, data.first if !data.empty?
  end

  def test_journals
    response = client.journals.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.journals response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Journal, data.first if !data.empty?
  end

  def test_organisations
    response = client.organisational_units.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.organisations response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Organisation, data.first if !data.empty?
  end

  def test_persons
    response = client.persons.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.persons response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Person, data.first if !data.empty?
  end

  def test_projects
    response = client.projects.all params: { size: collection_size }
    data = Puree::XMLExtractor::ResourceCollection.projects response.to_s
    puts data
    assert_instance_of Array, data
    assert_instance_of Puree::Model::Project, data.first if !data.empty?
  end



end