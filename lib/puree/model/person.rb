module Puree
  module Model

    # A person.
    #
    class Person < Resource

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      attr_accessor :affiliations

      # @return [Array<String>]
      attr_accessor :email_addresses

      # @return [Array<Model::Identifier>]
      attr_accessor :identifiers

      # @return [Array<String>]
      attr_accessor :image_urls

      # @return [Array<String>]
      attr_accessor :keywords

      # @return [Puree::Model::PersonName, nil]
      attr_accessor :name

      # @return [String, nil]
      attr_accessor :orcid

      # @return [Array<Model::PersonName>]
      attr_accessor :other_names
    end
  end
end