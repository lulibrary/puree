module Puree
  module Model
    class Event < Struct.new(*Resource.members,

                             :city,
                             :country,
                             :date,
                             :description,
                             :location,
                             :title,
                             :type
    )

    end
  end
end