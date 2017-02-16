module Puree

  class Publication < Struct.new(*Resource.members,

    :category,
    :description,
    :doi,
    :event,
    :file,
    :organisation,
    :page,
    :person,
    :status,
    :subtitle,
    :title,
    :type
    
    )

  end
  
end