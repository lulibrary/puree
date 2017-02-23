module Puree
  module Model
    class Dataset < Struct.new(*Resource.members,
                               :access,
                               :associated,
                               :available,
                               :description,
                               :doi,
                               :files,
                               :keywords,
                               :links,
                               :legal_conditions,
                               :organisations,
                               :owner,
                               :persons_internal,
                               :persons_external,
                               :persons_other,
                               :production,
                               :projects,
                               :publications,
                               :publisher,
                               :spatial_places,
                               :spatial_point,
                               :temporal,
                               :title,
    )
    end
  end
end