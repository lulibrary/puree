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
      attr_accessor :doi

      # # @return [Fixnum, nil]
      attr_accessor :pages

      # @return [String, nil]
      attr_accessor :qualification

      # @return [Array<String>, nil]
      attr_accessor :sponsors

    end
  end
end