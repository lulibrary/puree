module Puree

  module Configuration

      attr_accessor :base_url, :username, :password, :basic_auth

      def configure
        yield self
      end

  end

end
