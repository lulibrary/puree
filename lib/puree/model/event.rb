module Puree
  module Model

    # An organised event
    #
    class Event < Resource

      # @return [String, nil]
      attr_accessor :city

      # @return [String, nil]
      attr_accessor :country

      # @return [Puree::Model::TemporalRange, nil]
      attr_accessor :date

      # @return [String, nil]
      attr_accessor :description

      # @return [String, nil]
      attr_accessor :location

      # @return [String, nil]
      attr_accessor :title

      # @return [String, nil]
      attr_accessor :type

    end
  end
end