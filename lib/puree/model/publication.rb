module Puree
  module Model

    # A publication.
    #
    class Publication < Resource

      # @return [Array<Puree::Model::RelatedContentHeader>]
      attr_accessor :associated

      # @return [String, nil]
      attr_accessor :bibliographical_note

      # @return [String, nil]
      attr_accessor :category

      # @return [String, nil]
      attr_accessor :description

      # @return [String, nil]
      attr_accessor :doi

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      attr_accessor :external_organisations

      # @return [Array<Puree::Model::File>]
      attr_accessor :files

      # @return [Array<String>]
      attr_accessor :keywords

      # @return [String, nil]
      attr_accessor :language

      # @return [Array<String>]
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

      # @return [String, nil]
      # attr_accessor :publication_place

      # @return [String, nil]
      # attr_accessor :publisher

      # @return [Array<Puree::Model::PublicationStatus>]
      attr_accessor :statuses

      # @return [String, nil]
      attr_accessor :subtitle

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :translated_subtitle

      # @return [String, nil]
      attr_accessor :translated_title

      # @return [String, nil]
      attr_accessor :type

      # @return [String, nil]
      attr_accessor :workflow

    end
  end
end