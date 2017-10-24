module Puree

  module Query

    # For querying information about a person.
    #
    class Person

      def initialize(config)
        @url = config[:url]
        @headers = {}
        basic_auth username: config[:username],
                   password: config[:password]
        @config = config
      end

      # Count of publications available for a person.
      #
      # @param uuid [String] person UUID.
      # @return [Fixnum]
      def publication_count(uuid:)
        params = {}
        params['associatedPersonUuids.uuid'] = uuid
        params['rendering'] = :system
        params['window.size'] = 0
        headers
        response = @req.get(build_publication_url, params: params)
        doc = make_doc response.body
        extract_publication_count doc
      end

      # Publications for a person.
      #
      # @param uuid [String] person UUID.
      # @param limit [Fixnum]
      # @param offset [Fixnum]
      # @param published_start [String] using format YYYY-MM-DD
      # @param published_end [String] using format YYYY-MM-DD
      # @return [Array<Puree::Model::Publication>]
      def publications(uuid:, limit:, offset: 0, published_start: nil, published_end: nil)
        uuids = publication_uuids(uuid: uuid,
                                  limit: limit,
                                  offset: offset,
                                  published_start: published_start,
                                  published_end: published_end)
        publications = []
        uuids.each do |uuid|
          publication_extractor = Puree::Extractor::Publication.new @config
          publication = publication_extractor.find uuid: uuid
          publications << publication if publication
        end
        publications
      end


      private

      def publication_uuids(uuid:, limit:, offset: 0, published_start: nil, published_end: nil)
        params = {}
        params['associatedPersonUuids.uuid'] = uuid
        params['rendering'] = :system
        params['window.size'] = limit.to_s
        params['window.offset'] = offset if limit > 0
        params['publicationDate.fromDate'] = published_start if published_start
        params['publicationDate.toDate'] = published_end if published_end
        headers
        response = @req.get(build_publication_url, params: params)
        doc = make_doc response.body
        extract_publication_uuids doc
      end

      def make_doc(xml)
        doc = Nokogiri::XML xml
        doc.remove_namespaces!
        doc
      end

      def extract_publication_count(doc)
        doc.xpath('/GetPublicationResponse/count').text.strip.to_i
      end

      def extract_publication_uuids(doc)
        records = doc.xpath('/GetPublicationResponse/result/renderedItem')
        uuids = []
        records.each do |record|
          uuid = extract_publication_uuid record
          uuids << uuid
        end
        uuids
      end

      def extract_publication_uuid(doc)
        doc.xpath('@renderedContentUUID').text.strip
      end

      def build_publication_url
        "#{@url}/publication.current"
      end

      # Provide credentials if necessary
      #
      # @param username [String]
      # @param password [String]
      def basic_auth(username:, password:)
        auth = Base64::strict_encode64("#{username}:#{password}")
        @headers['Authorization'] = 'Basic ' + auth
      end

      def headers
        @headers['Accept'] = 'application/xml'
        @req = HTTP.headers accept: @headers['Accept']
        if @headers['Authorization']
          @req = @req.auth @headers['Authorization']
        end
      end

    end

  end

end