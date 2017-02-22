module Puree
  module Model
    class Organisation < Struct.new(*Resource.members,
                                    :address,
                                    :email_addresses,
                                    :name,
                                    :organisations,
                                    :parent,
                                    :phone_numbers,
                                    :type,
                                    :urls

    )
    end
  end
end