module Puree
  module Model
    class Resource < Struct.new(
        :uuid,
        :created,
        :modified,
        :locale
    )
    end
  end
end