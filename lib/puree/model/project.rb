module Puree
  module Model

    # A project.
    #
    class Project < Resource

      # @return [String, nil]
      attr_accessor :acronym

      # not present in stable API
      # @return [Array<Puree::Model::RelatedContentHeader>]
      # attr_accessor :associated

      # @return [String, nil]
      attr_accessor :description

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      attr_accessor :external_organisations

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

      # @return [Array<Model::ProjectIdentifier>]
      attr_accessor :identifiers

      # @return [String, nil]
      attr_accessor :status

      # @return [Puree::Model::TemporalRange, nil]
      attr_accessor :temporal

      # @return [Puree::Model::TemporalRange, nil]
      # attr_accessor :temporal_expected

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :type

      # @return [String, nil]
      attr_accessor :url

    end
  end
end