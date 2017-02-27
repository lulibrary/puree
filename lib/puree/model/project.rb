module Puree
  module Model
    class Project < Resource

      # @return [String, nil]
      attr_accessor :acronym

      # @return [String, nil]
      attr_accessor :description

      # @return [Array<Puree::Model::OrganisationHeader>]
      attr_accessor :organisations

      # @return [Puree::Model::OrganisationHeader]
      attr_accessor :owner

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_other

      # @return [String, nil]
      attr_accessor :status

      # @return [Puree::Model::TemporalRange]
      attr_accessor :temporal_actual

      # @return [Puree::Model::TemporalRange]
      attr_accessor :temporal_expected

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :type

      # @return [String, nil]
      attr_accessor :url

    end
  end
end