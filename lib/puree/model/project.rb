module Puree
  module Model
    class Project < Struct.new(*Resource.members,
                               :acronym,
                               :description,
                               :organisations,
                               :owner,
                               :persons_internal,
                               :persons_external,
                               :persons_other,
                               :status,
                               :temporal_actual,
                               :temporal_expected,
                               :title,
                               :type,
                               :url
    )
    end
  end
end