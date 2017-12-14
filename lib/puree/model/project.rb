module Puree
  module Model

    # A project.
    #
    class Project < Resource

      # @return [String, nil]
      attr_accessor :acronym

      # @return [String, nil]
      attr_accessor :description

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      attr_accessor :external_organisations

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      attr_accessor :organisational_units

      # @return [Puree::Model::OrganisationalUnitHeader, nil]
      attr_accessor :owner

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_other

      # @return [Array<Model::Identifier>]
      attr_accessor :identifiers

      # @return [String, nil]
      attr_accessor :status

      # @return [Puree::Model::TemporalRange, nil]
      attr_accessor :temporal

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :type

      # @return [String, nil]
      attr_accessor :url

    end
  end
end