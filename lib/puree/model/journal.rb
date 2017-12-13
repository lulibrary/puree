module Puree
  module Model

    # A journal.
    #
    class Journal < Resource

      # @return [String, nil]
      attr_accessor :issn

      # @return [String, nil]
      attr_accessor :publisher

      # @return [String, nil]
      attr_accessor :title

    end
  end

end