module Puree

  class Organisation < Struct.new(*Resource.members,

    :address,
    :email,
    :name,
    :organisation,
    :parent,
    :phone,
    :type,
    :url

    )

  end
  
end