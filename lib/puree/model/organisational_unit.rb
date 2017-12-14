module Puree
  module Model

    # An organisational unit as defined by the institution.
    #
    class OrganisationalUnit < Resource

      # @return [Puree::Model::Address]
      attr_accessor :address

      # @return [Array<String>]
      attr_accessor :email_addresses

      # @return [String, nil]
      attr_accessor :name

      # @return [Array<Puree::Model::OrganisationHeader>]
      # attr_accessor :organisations

      # @return [Puree::Model::OrganisationHeader, nil]
      attr_accessor :parent

      # @return [Array<String>]
      attr_accessor :phone_numbers

      # @return [String, nil]
      attr_accessor :type

      # @return [Array<String>]
      attr_accessor :urls

    end
  end
end