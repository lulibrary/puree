module Puree

  class Resource < Struct.new(

      :uuid,
      :created,
      :modified,
      :locale

    )

  end

end