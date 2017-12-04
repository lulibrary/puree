require 'sax-machine'

module Puree
  module ModelFoo
    class Dataset
      include SAXMachine
      # include Puree::ModelFoo::System

      element :associated

      # Date made available.
      # @return [Time, nil]
      element :available

      # @return [String, nil]
      element :description

      # Digital Object Identifier.
      # @return [String, nil]
      element :doi

      # Supporting files.
      # @return [Array<Puree::Model::File>]
      element :files

      # @return [Array<String>]
      element :keywordGroup, as: :keyword_group,
               class: Puree::ModelFoo::UserDefinedKeywords, with: {
          logicalName:"User-Defined Keywords"
      }

      element :info, class: Puree::ModelFoo::Info

      # @return [Array<Puree::Model::OrganisationHeader>]
      elements :organisationalUnit, as: :organisations, class: Puree::ModelFoo::OrganisationHeader

      # @return [Puree::Model::OrganisationHeader, nil]
      element :managingOrganisationalUnit, as: :owner, class: Puree::ModelFoo::OrganisationHeader

      # @return [Array<Puree::Model::EndeavourPerson>]
      element :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      element :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      element :persons_other

      # Date of data production.
      # @return [Puree::Model::TemporalRange, nil]
      element :dataProductionPeriod, as: :production, class: Puree::ModelFoo::TemporalRange

      # @return [Array<Puree::Model::RelatedContentHeader>]
      # element :projects

      # @return [Array<Puree::Model::RelatedContentHeader>]
      element :publications

      # @return [String, nil]
      element :publisher

      # @return [Array<String>]
      element :spatial_places

      # Spatial coverage point.
      # @return [Puree::Model::SpatialPoint, nil]
      element :spatial_point

      # Temporal coverage.
      # @return [Puree::Model::TemporalRange, nil]
      element :temporalCoveragePeriod, as: :temporal, class: Puree::ModelFoo::TemporalRange

      # @return [String, nil]
      element :title

      # @return [String, nil]
      element :workflow_state


    end
  end
end