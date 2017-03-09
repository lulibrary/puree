module Puree
  module Model

    # A structure.
    #
    class Structure

      def data?
        found = false
        instance_variables.each { |i|
          found = true if i
        }
        found
      end

    end
  end
end