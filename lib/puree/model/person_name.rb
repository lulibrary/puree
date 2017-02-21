module Puree

  class PersonName < Struct.new(

      :first,
      :last

  )

    # @return [String]
    def first_last
      "#{first} #{last}"
    end

    # @return [String]
    def last_first
      "#{last}, #{first}"
    end

    # @return [String]
    def initial_last
      "#{first[0,1]}. #{last}"
    end

    # @return [String]
    def last_initial
      "#{last}, #{first[0,1]}"
    end

  end
  
end