module Puree
  module Model

    # A publisher.
    #
    class Publisher < Resource

      # @return [String, nil]
      attr_accessor :name

      # @return [String, nil]
      attr_accessor :type

    end
  end
end