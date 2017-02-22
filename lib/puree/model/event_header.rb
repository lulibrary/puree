module Puree
  module Model
    class EventHeader < Struct.new(
        :uuid,
        :title
    )
    end
  end
end