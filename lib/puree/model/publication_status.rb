module Puree
  module Model
    class PublicationStatus < Struct.new(
        :stage,
        :date
    )
    end
  end
end