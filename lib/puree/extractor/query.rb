module Puree

  # A query extractor can retrieve any number of resources of the same type.
  #
  class Query

    def initialize(config)
      @url = config[:url]
      @headers = {}
      basic_auth username: config[:username],
                 password: config[:password]
      @config = config
    end

    # Gets an array of objects of resource type specified in constructor.
    #
    # @param uuid [String]
    # @param id [String]
    # @param limit [Fixnum]
    # @param offset [Fixnum]
    # @param published_start [String] using format YYYY-MM-DD
    # @param published_end [String] using format YYYY-MM-DD
    # @return [Array<Puree::Model::Publication>]
    def researcher_output(
            uuid: nil,
            id: nil,
            limit:            0,
            offset:           0,
            published_start:    nil,
            published_end:      nil
    )
      @uuid = uuid
      @id = id
      @limit = limit
      @offset = offset
      @published_start = published_start
      @published_end = published_end

      # strip any trailing slash
      @url = @url.sub(/(\/)+$/, '')
      @headers['Accept'] = 'application/xml'
      @req = HTTP.headers accept: @headers['Accept']
      if @headers['Authorization']
        @req = @req.auth @headers['Authorization']
      end
      @response = @req.get(build_url, params: params)

      puts @response.inspect

      # set_content @response.body
    end

    # Publication funders
    # @param uuid [String] Publication UUID.
    # @return [Array<String>] List of funder names which have funded this publication via a project.
    def publication_funders(uuid:)
      funders = []
      publication_extractor = Puree::Extractor::Publication.new @config
      publication = publication_extractor.find uuid: uuid
      if publication
        publication.associated.each do |associated|
          if associated.type == 'Research'
            project_extractor = Puree::Extractor::Project.new @config
            project = project_extractor.find uuid: associated.uuid
            if project.funded
              project.external_organisations.each do |org|
                external_organisation_extractor = Puree::Extractor::ExternalOrganisation.new @config
                external_organisation = external_organisation_extractor.find uuid: org.uuid
                funders << external_organisation.name if external_organisation.type == '/dk/atira/pure/ueoexternalorganisation/ueoexternalorganisationtypes/ueoexternalorganisation/researchFundingBody'
              end
            end
          end
        end
      end
      funders.uniq
    end


    private

    def params
      query = {}
      if @uuid
        query['associatedPersonUuids.uuid'] = @uuid
      else
        if @id
          query['associatedPersonPureInternalIds.id'] = @id
        end
      end
      query['rendering'] = :xml_long
      query['window.size'] = @limit
      query['window.offset'] = @offset if @limit > 0
      query['createdDate.toDate'] = @published_start if @published_start
      query['createdDate.fromDate'] = @published_end if @published_end
      query
    end

    def build_url

      # service = @api_map.service_name(@resource_type)
      # if @latest_api === false
      #   service_api_mode = service
      # else
      #   service_api_mode = service + '.current'
      # end
      "#{@url}/publication.current/"
    end

    # Provide credentials if necessary
    #
    # @param username [String]
    # @param password [String]
    def basic_auth(username:, password:)
      auth = Base64::strict_encode64("#{username}:#{password}")
      @headers['Authorization'] = 'Basic ' + auth
    end

  end

end