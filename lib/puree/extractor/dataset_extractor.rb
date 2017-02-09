module Puree

  # Extractor
  #
  module Extractor

    # Dataset extractor
    #
    module Dataset

      def self.extract_file(xpath_result)
        docs = []
        xpath_result.each do |d|
          doc = {}
          # doc['id'] = f.xpath('id').text.strip
          doc['name'] = d.xpath('fileName').text.strip
          doc['mime'] = d.xpath('mimeType').text.strip
          doc['size'] = d.xpath('size').text.strip
          doc['url'] = d.xpath('url').text.strip
          doc['title'] = d.xpath('title').text.strip
          # doc['createdDate'] = d.xpath('createdDate').text.strip
          # doc['visibleOnPortalDate'] = d.xpath('visibleOnPortalDate').text.strip
          # doc['limitedVisibility'] = d.xpath('limitedVisibility').text.strip
          license = {}
          license_name = d.xpath('documentLicense/term/localizedString').text.strip
          license['name'] = license_name
          license_url = d.xpath('documentLicense/description/localizedString').text.strip
          license['url'] = license_url
          doc['license'] = license
          docs << doc
        end
        docs.uniq
      end

      def self.extract_keyword(xpath_result)
        data_arr = xpath_result.map { |i| i.text.strip }
        data_arr.uniq
      end

      def self.extract_link(xpath_result)
        data = []
        xpath_result.each { |i|
          o = {}
          o['url'] = i.xpath('url').text.strip
          o['description'] = i.xpath('description').text.strip
          data << o
        }
        data.uniq
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
          role_uri = i.xpath('personRole/uri').text.strip
          o['role'] = roles[role_uri].to_s
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

      def self.extract_spatial(xpath_result)
        # Data from free-form text box
        data = []
        xpath_result.each do |i|
          data << i.text.strip
        end
        data
      end

      def self.extract_spatial_point(xpath_result)
        o = {}
        if !xpath_result[0].nil?
          arr = xpath_result.text.split(',')
          o['latitude'] = arr[0].strip.to_f
          o['longitude'] = arr[1].strip.to_f
        end
        o
      end

      def self.roles
        {
            '/dk/atira/pure/dataset/roles/dataset/contributor'    => 'Contributor',
            '/dk/atira/pure/dataset/roles/dataset/creator'        => 'Creator',
            '/dk/atira/pure/dataset/roles/dataset/datacollector'  => 'Data Collector',
            '/dk/atira/pure/dataset/roles/dataset/datamanager'    => 'Data Manager',
            '/dk/atira/pure/dataset/roles/dataset/distributor'    => 'Distributor',
            '/dk/atira/pure/dataset/roles/dataset/editor'         => 'Editor',
            '/dk/atira/pure/dataset/roles/dataset/funder'         => 'Funder',
            '/dk/atira/pure/dataset/roles/dataset/owner'          => 'Owner',
            '/dk/atira/pure/dataset/roles/dataset/other'          => 'Other',
            '/dk/atira/pure/dataset/roles/dataset/producer'       => 'Producer',
            '/dk/atira/pure/dataset/roles/dataset/rightsholder'   => 'Rights Holder',
            '/dk/atira/pure/dataset/roles/dataset/sponsor'        => 'Sponsor',
            '/dk/atira/pure/dataset/roles/dataset/supervisor'     => 'Supervisor'
        }
      end

    end

  end

end