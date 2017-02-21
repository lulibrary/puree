module Puree

  class Address < Struct.new(

      :street,
      :building,
      :postcode,
      :city,
      :country
  )

  end

end