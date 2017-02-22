module Puree
  module Model
    class EndeavourPerson < Struct.new(
        :name,
        :role,
        :uuid
    )
    end
  end
end