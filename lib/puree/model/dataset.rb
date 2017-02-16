module Puree

  class Dataset < Struct.new(*Resource.members,

      :access,
      :associated,
      :available,
      :description,
      :doi,
      :file,
      :keyword,
      :link,
      :organisation,
      :owner,
      :person,
      :production,
      :project,
      :publication,
      :publisher,
      :spatial,
      :spatial_point,
      :temporal,
      :title,
    )

  end

end