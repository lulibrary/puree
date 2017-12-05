require 'happymapper'
require 'puree/happy_mapper/xml_mapper_managing_organisational_unit'

module Purifier
  class Dataset < Purifier::Resource
    include HappyMapper

    include Purifier::RelatedResearchOutputMixin

    tag 'dataSet'
    # include Puree::ModelFoo::System

    # element :associated
    #
    # # Date made available.
    # # @return [Time, nil]
    # element :available
    #

    # @return [String]
    has_one :description, String


    #
    # Digital Object Identifier.
    # @return [String]
    has_one :doi, String
    #
    # # Supporting files.
    # # @return [Array<Puree::Model::File>]
    # element :files
    #

    # @return [Array<String>]
    has_many :user_defined_keywords, String, xpath: 'keywordGroups/keywordGroup[@logicalName="User-Defined Keywords"]/keywords/keyword'

    # @return [Array<Purifier::OrganisationalUnitHeader>]
    has_many :organisational_units, Purifier::OrganisationalUnitHeader, xpath: 'organisationalUnits'

    # @return [Purifier::ManagingOrganisationalUnitHeader]
    has_one :managing_organisational_unit, Purifier::ManagingOrganisationalUnitHeader

    # @return [Array<Purifier::PersonHeader>]
    has_many :internal_person_associations, Purifier::InternalPersonAssociation, tag: 'personAssociation'

    # # @return [Array<Puree::Model::EndeavourPerson>]
    # element :persons_external
    #
    # # @return [Array<Puree::Model::EndeavourPerson>]
    # element :persons_other
    #
    # # Date of data production.
    # # @return [Puree::Model::TemporalRange, nil]
    # element :dataProductionPeriod, as: :production, class: Puree::ModelFoo::TemporalRange
    #
    # # @return [Array<Puree::Model::RelatedContentHeader>]
    # # element :projects

    # # @return [Array<Puree::Mapper::RelatedResearchOutputHeader>]
    # element :related_research_outputs, Puree::Mapper::RelatedResearchOutputHeader

    # @return [Purifier::PublisherHeader]
    has_one :publisher, Purifier::PublisherHeader

    # # @return [Array<String>]
    # element :spatial_places,

    has_many :geographical_coverage, String, tag: 'geographicalCoverage'

    # element :keywordGroups, Array
    #
    # # Spatial coverage point.
    # # @return [Puree::Model::SpatialPoint, nil]
    # element :spatial_point
    #
    # # Temporal coverage.
    # # @return [Puree::Model::TemporalRange, nil]
    # element :temporalCoveragePeriod, as: :temporal, class: Puree::ModelFoo::TemporalRange

    # @return [String]
    has_one :title, String

    # @return [String]
    has_one :workflow, String
  end
end