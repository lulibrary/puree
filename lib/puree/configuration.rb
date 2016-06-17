module Puree

  module Configuration

      attr_accessor :endpoint, :username, :password, :basic_auth

      def configure
        yield self
      end

  end

end
