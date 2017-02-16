module Puree

  class Journal < Struct.new(*Resource.members,

    :issn,
    :publisher,
    :title
  )

  end
  
end