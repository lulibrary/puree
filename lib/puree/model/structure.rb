module Puree
  module Model

    # A structure.
    #
    class Structure

      def data?
        instance_variables.each { |i| return true if !i.nil? }
      end

    end
  end
end