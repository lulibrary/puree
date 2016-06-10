module Puree

  module Configuration

    class << self

      attr_accessor :endpoint, :username, :password

      def configure
        yield self
      end

    end

  end

end
