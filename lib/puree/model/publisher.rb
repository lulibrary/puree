module Puree
  module Model
    class Publisher < Struct.new(*Resource.members,
                                 :name
    )
    end
  end
end