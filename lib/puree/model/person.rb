module Puree

  class Person < Struct.new(*Resource.members,

    :affiliation,
    :email,
    :image,
    :keyword,
    :name,
    :orcid

    )

  end
  
end