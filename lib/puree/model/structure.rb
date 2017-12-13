module Puree
  module Model

    # A structure.
    #
    class Structure

      def data?
        found = false
        instance_variables.each do |i|
          found = true if i
        end
        found
      end

    end
  end
end