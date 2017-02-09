module Puree

  # Extractor
  #
  module Extractor

    # Project extractor
    #
    module Project

      def self.extract_person(xpath_result)
        data = {}
        internal = []
        external = []
        other = []
        xpath_result.each do |i|
          o = {}
          name = {}
          name['first'] = i.xpath('person/name/firstName').text.strip
          name['last'] = i.xpath('person/name/lastName').text.strip
          o['name'] = name
          o['role'] = i.xpath('personRole/term/localizedString').text.strip

          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            o['uuid'] = uuid_internal.text.strip
            internal << o
          elsif uuid_external
            o['uuid'] = uuid_external.text.strip
            external << o
          else
            other << o
            o['uuid'] = ''
          end
        end
        data['internal'] = internal
        data['external'] = external
        data['other'] = other
        data
      end

    end

  end

end