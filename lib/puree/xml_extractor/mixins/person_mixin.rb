module Puree

  module XMLExtractor

    # Person mixin.
    #
    module PersonMixin

      private

      # @return [Array<Puree::Model::EndeavourPerson>]
      def persons(type, xpath_query_path)
        xpath_result = xpath_query xpath_query_path
        arr = []
        xpath_result.each do |i|
          uuid_internal = i.at_xpath('person/@uuid')
          uuid_external = i.at_xpath('externalPerson/@uuid')
          if uuid_internal
            person_type = 'internal'
            uuid = uuid_internal.text.strip
          elsif uuid_external
            person_type = 'external'
            uuid = uuid_external.text.strip
          else
            person_type = 'other'
            uuid = ''
          end
          if person_type === type
            person = Puree::Model::EndeavourPerson.new
            person.uuid = uuid
            name = Puree::Model::PersonName.new
            name.first = i.xpath('name/firstName').text.strip
            name.last = i.xpath('name/lastName').text.strip
            person.name = name if name.data?
            xpath_result_role = i.xpath('personRole/term/text')
            person.role = xpath_result_role.first.text.strip unless xpath_result_role.empty?
            arr << person if person.data?
          end
        end
        arr
      end

    end

  end
end
