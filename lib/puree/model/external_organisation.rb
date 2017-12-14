module Puree
  module Model

    # An external organisation as defined by the institution.
    #
    class ExternalOrganisation < Resource

      # @return [String, nil]
      attr_accessor :name

      # @return [String, nil]
      attr_accessor :type

    end
  end
end