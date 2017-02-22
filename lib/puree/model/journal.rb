module Puree
  module Model
    class Journal < Struct.new(*Resource.members,

                               :issn,
                               :publisher,
                               :title
    )
    end
  end

end