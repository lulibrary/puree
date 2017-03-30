module Puree
  module Model

    # A thesis.
    #
    class Thesis < Puree::Model::Publication

      # @return [Time, nil]
      attr_accessor :award_date

      # @return [Puree::Model::OrganisationHeader, nil]
      attr_accessor :awarding_institution

      # @return [String, nil]
      attr_accessor :qualification

      # @return [Array<String>, nil]
      attr_accessor :sponsors


      # # @return [String, nil]
      # attr_accessor :category
      #
      # # @return [String, nil]
      # attr_accessor :description
      #
      # # @return [String, nil]
      # attr_accessor :doi
      #
      # # @return [Puree::Model::EventHeader, nil]
      # attr_accessor :event
      #
      # # @return [Array<Puree::Model::File>]
      # attr_accessor :files
      #
      # # @return [Array<String>]
      # attr_accessor :keywords
      #
      # # @return [Array<Puree::Model::OrganisationHeader>]
      # attr_accessor :organisations
      #
      # # @return [Puree::Model::OrganisationHeader, nil]
      # attr_accessor :owner
      #
      # # @return [Fixnum, nil]
      # attr_accessor :pages
      #
      # # @return [Array<Puree::Model::EndeavourPerson>]
      # attr_accessor :persons_internal
      #
      # # @return [Array<Puree::Model::EndeavourPerson>]
      # attr_accessor :persons_external
      #
      # # @return [Array<Puree::Model::EndeavourPerson>]
      # attr_accessor :persons_other
      #
      # # @return [String, nil]
      # attr_accessor :publisher
      #
      # # @return [Array<Puree::Model::PublicationStatus>]
      # attr_accessor :statuses
      #
      # # @return [String, nil]
      # attr_accessor :subtitle
      #
      # # @return [String, nil]
      # attr_accessor :title
      #
      # # @return [String, nil]
      # attr_accessor :type


    end
  end
end