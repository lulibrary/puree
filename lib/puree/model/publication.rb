module Puree
  module Model
    class Publication < Struct.new(*Resource.members,
                                   :category,
                                   :description,
                                   :doi,
                                   :event,
                                   :files,
                                   :organisations,
                                   :page,
                                   :persons_internal,
                                   :persons_external,
                                   :persons_other,
                                   :statuses,
                                   :subtitle,
                                   :title,
                                   :type
    )
    end
  end
end