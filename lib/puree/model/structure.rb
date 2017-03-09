module Puree
  module Model

    # A structure.
    #
    class Structure

      def data?
        instance_variables.each { |i| return true if i }
      end

    end
  end
end