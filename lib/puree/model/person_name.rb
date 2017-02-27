module Puree
  module Model
    class PersonName

      # @return [String, nil]
      attr_accessor :first

      # @return [String, nil]
      attr_accessor :last


      # @return [String]
      def first_last
        "#{first} #{last}"
      end

      # @return [String]
      def last_first
        "#{last}, #{first}"
      end

      # @return [String]
      def initial_last
        "#{first[0, 1]}. #{last}"
      end

      # @return [String]
      def last_initial
        "#{last}, #{first[0, 1]}."
      end

    end
  end
end