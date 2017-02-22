module Puree
  module Model
    class LegalCondition < Struct.new(
        :name,
        :description
    )
    end
  end
end