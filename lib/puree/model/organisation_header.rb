module Puree
  module Model
    class OrganisationHeader < Struct.new(
        :uuid,
        :name,
        :type
    )
    end
  end
end