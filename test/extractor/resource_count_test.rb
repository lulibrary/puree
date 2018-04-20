require 'test_helper'

class TestResourceCount < Minitest::Test

  def test_dataset_count
    extractor = Puree::Extractor::Dataset.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_external_organisation_count
    extractor = Puree::Extractor::ExternalOrganisation.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_event_count
    extractor = Puree::Extractor::Event.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_journal_count
    extractor = Puree::Extractor::Journal.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_organisational_unit_count
    extractor = Puree::Extractor::OrganisationalUnit.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_person_count
    extractor = Puree::Extractor::Person.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_project_count
    extractor = Puree::Extractor::Project.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_publisher_count
    extractor = Puree::Extractor::Publisher.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

  def test_research_output_count
    extractor = Puree::Extractor::ResearchOutput.new config
    count = extractor.count

    assert_instance_of Fixnum, count
  end

end