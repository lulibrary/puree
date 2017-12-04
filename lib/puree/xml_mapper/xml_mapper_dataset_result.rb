require 'sax-machine'

module Puree
  module ModelFoo
    class DatasetCollection
      include SAXMachine

      # @return [Array<Puree::ModelFoo::Dataset>]
      elements :dataSet, as: :datasets, class: Puree::ModelFoo::Dataset
    end
  end
end