require 'happymapper'
require 'puree/happy_mapper/xml_mapper_managing_organisational_unit'

module Puree
  module Mapper
    class Dataset < Puree::Mapper::Resource
      include HappyMapper

      include Puree::Mapper::RelatedResearchOutputMixin

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
      # # @return [Array<String>]
      # element :keywordGroup, as: :keyword_group,
      #          class: Puree::ModelFoo::UserDefinedKeywords, with: {
      #     logicalName:"User-Defined Keywords"
      # }

      # @return [Array<Puree::Mapper::OrganisationalUnitHeader>]
      has_many :organisational_units, Puree::Mapper::OrganisationalUnitHeader, xpath: 'organisationalUnits'
      #
      # @return [Puree::Mapper::ManagingOrganisationalUnitHeader]
      has_one :managing_organisational_unit, Puree::Mapper::ManagingOrganisationalUnitHeader

      # # @return [Array<Puree::Model::EndeavourPerson>]
      # element :persons_internal
      #
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

      # @return [Puree::Mapper::PublisherHeader]
      has_one :publisher, Puree::Mapper::PublisherHeader

      # # @return [Array<String>]
      # element :spatial_places,

      # element :geographicalCoverage, String

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
end