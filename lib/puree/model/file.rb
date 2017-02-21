module Puree

  class File < Struct.new(
      
      :name,
      :mime,
      :size,
      :url,
      :license
  )

  end
  
end