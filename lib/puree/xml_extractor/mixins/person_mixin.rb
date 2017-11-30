module Puree

  module XMLExtractor

    # Person mixin.
    #
    module PersonMixin

      private

      # @return [Array<Endeavour::Person>]
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
            person.name = name

            # role_uri = i.xpath('personRole/uri').text.strip
            # person.role = roles[role_uri]
            person.role = i.xpath('personRole').text.strip

            arr << person if person.data?
          end
        end
        # does not work properly using uuid as some people don't have one
        arr.uniq { |d| "#{d.name.last}#{d.name.first}#{d.role}" }
      end

    end

  end
end
