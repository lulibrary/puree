require 'test_helper'

class TestResourceRandom < Minitest::Test

  def test_dataset_random
    extractor = Puree::Extractor::Dataset.new config

    assert_instance_of Puree::Model::Dataset, extractor.random
  end

  def test_external_organisation_random
    extractor = Puree::Extractor::ExternalOrganisation.new config

    assert_instance_of Puree::Model::ExternalOrganisation, extractor.random
  end

  def test_event_random
    extractor = Puree::Extractor::Event.new config

    assert_instance_of Puree::Model::Event, extractor.random
  end

  def test_journal_random
    extractor = Puree::Extractor::Journal.new config

    assert_instance_of Puree::Model::Journal, extractor.random
  end

  def test_organisational_unit_random
    extractor = Puree::Extractor::OrganisationalUnit.new config

    assert_instance_of Puree::Model::OrganisationalUnit, extractor.random
  end

  def test_person_random
    extractor = Puree::Extractor::Person.new config

    assert_instance_of Puree::Model::Person, extractor.random
  end

  def test_project_random
    extractor = Puree::Extractor::Project.new config

    assert_instance_of Puree::Model::Project, extractor.random
  end

  def test_publisher_random
    extractor = Puree::Extractor::Publisher.new config

    assert_instance_of Puree::Model::Publisher, extractor.random
  end

  def test_research_output_random
    extractor = Puree::Extractor::ResearchOutput.new config

    class_possibilities = [
        Puree::Model::ResearchOutput,
        Puree::Model::ConferencePaper,
        Puree::Model::Thesis,
        Puree::Model::JournalArticle
    ]
    random = extractor.random
    assert_includes class_possibilities, random.class
  end

end