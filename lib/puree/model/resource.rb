module Puree
  module Model
    class Resource

      # @return [String, nil]
      attr_accessor :uuid

      # @return [Time, nil]
      attr_accessor :created

      # @return [Time, nil]
      attr_accessor :modified

      # @return [String, nil]
      attr_accessor :locale

    end
  end
end