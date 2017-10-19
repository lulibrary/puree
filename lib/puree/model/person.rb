module Puree
  module Model

    # A person.
    #
    class Person < Resource

      # @return [Array<Puree::Model::OrganisationHeader>]
      attr_accessor :affiliations

      # @return [Array<String>]
      attr_accessor :email_addresses

      # @return [String, nil]
      attr_accessor :employee_id

      # @return [Array<String>]
      attr_accessor :image_urls

      # @return [Array<String>]
      attr_accessor :keywords

      # @return [Puree::Model::PersonName, nil]
      attr_accessor :name

      # @return [String, nil]
      attr_accessor :orcid

    end
  end
end