module Puree
  module Model

    # A Research output.
    #
    class ResearchOutput < Resource

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

      # @return [String, nil]
      attr_accessor :open_access_permission

      # @return [Array<Puree::Model::OrganisationalUnitHeader>]
      attr_accessor :organisations

      # @return [Puree::Model::OrganisationalUnitHeader, nil]
      attr_accessor :owner

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_other

      # @return [Array<Puree::Model::PublicationStatus>]
      attr_accessor :publication_statuses

      # Related research outputs.
      # @return [Array<Puree::Model::RelatedContentHeader>]
      attr_accessor :research_outputs

      # @return [Fixnum, nil]
      attr_accessor :scopus_citations_count

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