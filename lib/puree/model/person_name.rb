module Puree
  module Model

    # The name of a person.
    #
    class PersonName < Puree::Model::Structure

      # @return [String, nil]
      attr_reader :first

      # @return [String, nil]
      attr_reader :last

      # @param v [String]
      def first=(v)
        @first = v if v && !v.empty?
      end

      # @param v [String]
      def last=(v)
        @last = v if v && !v.empty?
      end

      # @return [String]
      def first_last
        both? ? "#{first} #{last}" : 'One or both names missing'
      end

      # @return [String]
      def last_first
        both? ? "#{last}, #{first}" : 'One or both names missing'
      end

      # @return [String]
      def initial_last
        both? ? "#{first[0, 1]}. #{last}" : 'One or both names missing'
      end

      # @return [String]
      def last_initial
        both? ? "#{last}, #{first[0, 1]}." : 'One or both names missing'
      end

      private

      def both?
        !@first.nil? && !@last.nil? || false
      end

    end
  end
end