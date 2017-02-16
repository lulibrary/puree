module Puree

  class Project < Struct.new(*Resource.members,

    :acronym,
    :description,
    :organisation,
    :owner,
    :person,
    :status,
    :temporal,
    :title,
    :type,
    :url
    
    )

  end
  
end