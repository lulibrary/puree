module Puree
  module Model
    class Address < Struct.new(
        :street,
        :building,
        :postcode,
        :city,
        :country
    )
    end
  end
end