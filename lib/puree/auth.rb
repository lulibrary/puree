module Puree

  module Auth

    def flexible_auth(base_url, username, password, basic_auth)
      @base_url = base_url.nil? ? Puree.base_url : base_url
      @basic_auth = basic_auth.nil? ? Puree.basic_auth : basic_auth
      if @basic_auth === true
        @username = username.nil? ? Puree.username : username
        @password = password.nil? ? Puree.password : password
      end
    end

    # def flexi_auth(base_url, username, password)
    #   @base_url = base_url.nil? ? Puree.base_url : base_url
    #   @username = username.nil? ? Puree.username : username
    #   @password = password.nil? ? Puree.password : password
    # end

  end

end
