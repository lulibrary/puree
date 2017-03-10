module Puree

  module API

    # Configuration for Pure host and credentials.
    #
    class Configuration

      attr_reader :url, :username, :password

      def initialize(url:)
        raise 'Missing URL in configuration' if !url
        @url = url
      end

      # Provide Basic Authentication credentials if required
      #
      # @param username [String]
      # @param password [String]
      def basic_auth(username:, password:)
        @username = username
        @password = password
        msg = 'Credentials incomplete in configuration'
        raise msg if username && !password
        raise msg if password && !username
      end

      def basic_auth?
        @username && @password
      end

    end

  end

end
