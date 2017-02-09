module Puree

  # Extractor
  #
  module Extractor

    # Publication extractor
    #
    module Publication

      def self.extract_event(xpath_result)
        o = {}
        o['uuid'] = xpath_result.xpath('@uuid').text.strip
        o['title'] = xpath_result.xpath('title/localizedString').text.strip
        o
      end

      def self.extract_file(xpath_result)
        docs = []
        xpath_result.each do |d|
          doc = {}
          # doc['id'] = d.xpath('id').text
          doc['name'] = d.xpath('fileName').text.strip
          doc['mime'] = d.xpath('mimeType').text.strip
          doc['size'] = d.xpath('size').text.strip
          doc['url'] = d.xpath('url').text.strip
          docs << doc
        end
        docs.uniq
      end

      def self.extract_person(xpath_result)
        data = {}
        internal = []
        external = []
        other = []
        xpath_result.each do |i|
          o = {}
          name = {}
          name['first'] = i.xpath('name/firstName').text.strip
          name['last'] = i.xpath('name/lastName').text.strip
          o['name'] = name
          o['role'] = 'Author'

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

      def self.extract_status(xpath_result)
        data = []
        xpath_result.each do |i|
          o = {}
          o['stage'] = i.xpath('publicationStatus/term/localizedString').text.strip
          ymd = {}
          ymd['year'] = i.xpath('publicationDate/year').text.strip
          ymd['month'] = i.xpath('publicationDate/month').text.strip
          ymd['day'] = i.xpath('publicationDate/day').text.strip
          o['date'] = Puree::Date.normalise(ymd)
          data << o
        end
        data
      end

    end

  end

end