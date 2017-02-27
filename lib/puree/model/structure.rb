module Puree
  module Model
    class Structure

      def data?
        instance_variables.each { |i| return true if !i.nil? }
      end

    end
  end
end