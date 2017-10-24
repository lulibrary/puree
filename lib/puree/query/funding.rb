module Puree

  module Query

    # For querying information about funding.
    #
    class Funding

      def initialize(config)
        @config = config
      end

      # Project funders
      # @param uuid [String] Project UUID.
      # @return [Array<Puree::Model::ExternalOrganisation>] List of funders which have funded this project.
      def project_funders(uuid:)
        funders = []
        project_extractor = Puree::Extractor::Project.new @config
        project = project_extractor.find uuid: uuid
        if project
          if project.funded
            project.external_organisations.each do |org|
              external_organisation_extractor = Puree::Extractor::ExternalOrganisation.new @config
              external_organisation = external_organisation_extractor.find uuid: org.uuid
              funders << external_organisation if external_organisation.type == '/dk/atira/pure/ueoexternalorganisation/ueoexternalorganisationtypes/ueoexternalorganisation/researchFundingBody'
            end
          end
        end
        deduplicate_funders funders
      end

      # Publication funders
      # @param uuid [String] Publication UUID.
      # @return [Array<Puree::Model::ExternalOrganisation>] List of funders which have funded this publication via a project.
      def publication_funders(uuid:)
        funders = []
        publication_extractor = Puree::Extractor::Publication.new @config
        publication = publication_extractor.find uuid: uuid
        if publication
          publication.associated.each do |associated|
            if associated.type == 'Research'
              single_project_funders = project_funders uuid: associated.uuid
              funders += single_project_funders
            end
          end
        end
        deduplicate_funders funders
      end

      private

      def deduplicate_funders(funders)
        uuids_in_list = []
        funder_list = []
        funders.each do |funder|
          uuid = funder.uuid
          unless uuids_in_list.include? uuid
            funder_list << funder
            uuids_in_list << uuid
          end
        end
        funder_list
      end

    end

  end

end