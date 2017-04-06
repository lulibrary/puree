module Puree
  module Model

    # A dataset produced during some research.
    #
    class Dataset < Resource
      include Puree::Model::KeywordsMixin

      # Open access permission.
      # @return [String, nil]
      attr_accessor :access

      # Combines projects and publications.
      # @return [Array<Puree::Model::RelatedContentHeader>]
      attr_accessor :associated

      # Date made available.
      # @return [Time, nil]
      attr_accessor :available

      # @return [String, nil]
      attr_accessor :description

      # Digital Object Identifier.
      # @return [String, nil]
      attr_accessor :doi

      # Supporting files.
      # @return [Array<Puree::Model::File>]
      attr_accessor :files

      # @return [Array<String>]
      # attr_accessor :keywords

      # @return [Array<Puree::Model::LegalCondition>]
      attr_accessor :legal_conditions

      # @return [Array<Puree::Model::Link>]
      attr_accessor :links

      # @return [Array<Puree::Model::OrganisationHeader>]
      attr_accessor :organisations

      # @return [Puree::Model::OrganisationHeader, nil]
      attr_accessor :owner

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_other

      # Date of data production.
      # @return [Puree::Model::TemporalRange, nil]
      attr_accessor :production

      # @return [Array<Puree::Model::RelatedContentHeader>]
      attr_accessor :projects

      # @return [Array<Puree::Model::RelatedContentHeader>]
      attr_accessor :publications

      # @return [String, nil]
      attr_accessor :publisher

      # @return [Array<String>]
      attr_accessor :spatial_places

      # Spatial coverage point.
      # @return [Puree::Model::SpatialPoint, nil]
      attr_accessor :spatial_point

      # Temporal coverage.
      # @return [Puree::Model::TemporalRange, nil]
      attr_accessor :temporal

      # @return [String, nil]
      attr_accessor :title

    end
  end
end