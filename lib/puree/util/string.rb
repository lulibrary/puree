module Puree
  module Util

    # String utilities.
    module String

      # Titleize
      # Assumes underscore as separator.
      # e.g. foo_bar becomes FooBar
      #
      def self.titleize(x)
        arr = "#{x}".split('_')
        caps = arr.map { |i| i.capitalize }
        caps.join
      end

    end
  end
end