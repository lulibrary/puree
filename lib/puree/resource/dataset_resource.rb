module Puree
  
  class DatasetResource

    attr_accessor :access,
    :associated,
    :available,
    :created,
    :description,
    :doi,
    :file,
    :keyword,
    :link,
    :locale,
    :modified,
    :organisation,
    :owner,
    :person,
    :project,
    :production,
    :publication,
    :publisher,
    :spatial,
    :spatial_point,
    :temporal,
    :title,
    :uuid

    def initialize(access: '', associated: [], available: {}, created: '', description: '', doi: '', file: [], keyword: [], link: [], locale: '', modified: '', organisation: [], owner: {}, person: [], project: [], production: {}, publication: [], publisher: '', spatial: [], spatial_point: {}, temporal: {}, title: '', uuid: '')
      @access = access
      @associated = associated
      @available = available
      @created = created
      @description = description
      @doi = doi
      @file = file
      @keyword = keyword
      @link = link
      @locale = locale
      @modified = modified
      @organisation = organisation
      @owner = owner
      @person = person
      @project = project
      @production = production
      @publication = publication
      @publisher = publisher
      @spatial = spatial
      @spatial_point = spatial_point
      @temporal = temporal
      @title = title
      @uuid = uuid
    end

  end
  
end