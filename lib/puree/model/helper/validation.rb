module Puree
  module Model

    # Model validation.
    #
    module Validation
      def enforce_class(v, klass)
        raise ArgumentError, "Expected #{klass}. Got #{v.class}." unless v && v.is_a?(klass)
      end
    end

  end
end


