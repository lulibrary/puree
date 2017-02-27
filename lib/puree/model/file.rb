module Puree
  module Model
    class File

      # @return [String, nil]
      attr_accessor :name

      # @return [String, nil]
      attr_accessor :mime

      # @return [Fixnum, nil]
      attr_accessor :size

      # @return [String, nil]
      attr_accessor :url

      # @return [String, nil]
      attr_accessor :license

    end
  end
end