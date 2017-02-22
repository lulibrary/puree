module Puree
  module Model
    class RelatedContentHeader < Struct.new(
        :uuid,
        :title,
        :type
    )
    end
  end
end