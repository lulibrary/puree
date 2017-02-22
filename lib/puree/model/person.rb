module Puree
  module Model
    class Person < Struct.new(*Resource.members,
                              :affiliations,
                              :email_addresses,
                              :image_urls,
                              :keywords,
                              :name,
                              :orcid
    )
    end
  end
end