module Puree
  module Model
    class File < Struct.new(
        :name,
        :mime,
        :size,
        :url,
        :license
    )
    end
  end
end