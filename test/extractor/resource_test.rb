require 'test_helper'

class TestResourceFind < Minitest::Test

  def test_conference_paper
    # A Negative Effect of Evaluation Upon Analogical Problem Solving
    id = '96e1495e-70a2-4529-9721-33b2cb62df8d'
    extractor = Puree::Extractor::ConferencePaper.new config
    model = extractor.find id

    assert_instance_of Puree::Model::ConferencePaper, model
  end

  def test_dataset
    # The 2014 Ebola virus disease outbreak in West Africa
    id = 'b050f4b5-e272-4914-8cac-3bdc1e673c58'
    extractor = Puree::Extractor::Dataset.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Dataset, model
  end

  def test_event
    # 31st Annual European Meeting on Atmospheric Studies by Optical Methods and 1st International Riometer Workshop
    id = 'cd2bf302-4629-4f71-9c02-2dfe50a384bf'
    extractor = Puree::Extractor::Event.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Event, model
  end

  def test_external_organisation
    # STFC
    id = '2ea6bbc4-c957-4a07-a1e7-604a2d944c20'
    extractor = Puree::Extractor::ExternalOrganisation.new config
    model = extractor.find id

    assert_instance_of Puree::Model::ExternalOrganisation, model
  end

  def test_journal
    # Chemical Geology
    id = '95e40a10-1799-4e74-9a70-8b03f27d9acb'
    extractor = Puree::Extractor::Journal.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Journal, model
  end

  def test_journal_article
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    extractor = Puree::Extractor::JournalArticle.new config
    model = extractor.find id

    assert_instance_of Puree::Model::JournalArticle, model
  end

  def test_organisation
    # Faculty of Health and Medicine
    id = '8a58c4ad-2d5a-463a-841a-38839ff73a63'
    extractor = Puree::Extractor::Organisation.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Organisation, model
  end

  def test_person
    # Peter Diggle
    id = '811d7fc3-047a-40d2-89e6-c85d14a97fb8'
    extractor = Puree::Extractor::Person.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Person, model
  end

  def test_project
    # The Channel Scheme - Preston
    id = '2af1fb5c-ac04-40f3-9cb4-073fb92fcf96'
    extractor = Puree::Extractor::Project.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Project, model
  end

  def test_research_output
    # A theoretical framework for estimation of AUCs in complete and incomplete sampling designs
    id = 'a7c104d0-e243-463e-a2a4-b4e07bcfde3f'
    extractor = Puree::Extractor::ResearchOutput.new config
    model = extractor.find id

    assert_instance_of Puree::Model::ResearchOutput, model
  end

  def test_thesis
    # Multimodalita e 'city branding'
    id = '376173c0-fd7a-4d63-93d3-3f2e58e8dc01'
    extractor = Puree::Extractor::Thesis.new config
    model = extractor.find id

    assert_instance_of Puree::Model::Thesis, model
  end
end