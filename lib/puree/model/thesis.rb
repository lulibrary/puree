module Puree
  module Model

    # A thesis.
    #
    class Thesis < Puree::Model::ResearchOutput

      # @return [Time, nil]
      attr_accessor :award_date

      # @return [Puree::Model::OrganisationalUnitHeader, nil]
      attr_accessor :awarding_institution

      # @return [String, nil]
      attr_accessor :doi

      # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [Puree::Model::PublisherHeader, nil]
      attr_accessor :publisher

      # @return [String, nil]
      attr_accessor :qualification

      # @return [Array<Puree::Model::ExternalOrganisationHeader>]
      attr_accessor :sponsors

    end
  end
end