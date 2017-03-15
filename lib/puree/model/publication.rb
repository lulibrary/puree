module Puree
  module Model

    # A publication.
    #
    class Publication < Resource

      # @return [String, nil]
      attr_accessor :category

      # @return [String, nil]
      attr_accessor :description

      # @return [String, nil]
      attr_accessor :doi

      # @return [Puree::Model::EventHeader, nil]
      attr_accessor :event

      # @return [Array<Puree::Model::File>]
      attr_accessor :files

      # @return [Array<String>]
      attr_accessor :keywords

      # @return [Array<Puree::Model::OrganisationHeader>]
      attr_accessor :organisations

      # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_internal

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_external

      # @return [Array<Puree::Model::EndeavourPerson>]
      attr_accessor :persons_other

      # @return [Array<Puree::Model::PublicationStatus>]
      attr_accessor :statuses

      # @return [String, nil]
      attr_accessor :subtitle

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :type


    end
  end
end