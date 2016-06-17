module Puree

  # Project resource
  #
  class Project < Resource

    # @param endpoint [String]
    # @param optional username [String]
    # @param optional password [String]
    def initialize(endpoint: nil, username: nil, password: nil, basic_auth: nil)
      super(api: :project,
            endpoint: endpoint,
            username: username,
            password: password,
            bleeding: false,
            basic_auth: basic_auth)
    end



    # Acronym
    #
    # @return [String]
    def acronym
      path = service_xpath_base + 'acronym'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Description
    #
    # @return [String]
    def description
      # path = '//content/description/localizedString'
      path = service_xpath_base + 'description/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Owner
    #
    # @return [Hash]
    def owner
      # path = '//content/owner'
      path = service_xpath_base + 'owner'
      xpath_result =  xpath_query path
      o = {}
      o['uuid'] = xpath_result.xpath('@uuid').text.strip
      o['name'] = xpath_result.xpath('name/localizedString').text.strip
      o['type'] = xpath_result.xpath('typeClassification/term/localizedString').text.strip
      o
    end

    # Status
    #
    # @return [String]
    def status
      # path = '//content/status/term/localizedString'
      path = service_xpath_base + 'status/term/localizedString'
          xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Temporal, expected and actual start and end dates as UTC datetime.
    #
    # @return [Hash]
    def temporal
      o = {}
      o['expected'] = {}
      o['actual'] = {}

      path = '//expectedStartDate'
      # path = service_xpath_base + 'expectedStartDate'
      xpath_result =  xpath_query path
      o['expected']['start'] = xpath_result.text.strip

      path = '//expectedEndDate'
      # path = service_xpath_base + 'expectedEndDate'
      xpath_result =  xpath_query path
      o['expected']['end'] = xpath_result.text.strip

      # path = '//startFinishDate/startDate'
      path = service_xpath_base + 'startFinishDate/startDate'
      xpath_result =  xpath_query path
      o['actual']['start'] = xpath_result.text.strip

      # path = '//startFinishDate/endDate'
      path = service_xpath_base + 'startFinishDate/endDate'
      xpath_result =  xpath_query path
      o['actual']['end'] = xpath_result.text.strip

      o
    end

    # Title
    #
    # @return [String]
    def title
      # path = '//content/title/localizedString'
      path = service_xpath_base + 'title/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # Type
    #
    # @return [String]
    def type
      # path = '//content/typeClassification/term/localizedString'
      path = service_xpath_base + 'typeClassification/term/localizedString'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # URL
    #
    # @return [String]
    def url
      # path = '//projectURL'
      path = service_xpath_base + 'projectURL'
      xpath_result = xpath_query path
      xpath_result ? xpath_result.text.strip : ''
    end

    # All metadata
    #
    # @return [Hash]
    def metadata
      o = super
      o['acronym'] = acronym
      # o['access'] = access
      # o['associated'] = associated
      # o['available'] = available
      o['description'] = description
      # o['doi'] = doi
      # o['file'] = file
      # o['geographical'] = geographical
      # o['keyword'] = keyword
      # o['link'] = link
      o['owner'] = owner
      # o['person'] = person
      # o['project'] = project
      # o['production'] = production
      # o['publication'] = publication
      # o['publisher'] = publisher
      o['status'] = status
      o['temporal'] = temporal
      o['title'] = title
      o['type'] = type
      o['url'] = url
      o
    end

  end

end
