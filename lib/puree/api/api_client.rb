module Puree

  module API

    # Requests for all resources
    #
    class APIClient

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        @config = config
      end

      # @return [Puree::API::Activity]
      def activities
        Puree::API::Activity.new @config
      end

      # @return [Puree::API::Application]
      def applications
        Puree::API::Application.new @config
      end

      # @return [Puree::API::ClassificationScheme]
      def classification_schemes
        Puree::API::ClassificationScheme.new @config
      end

      # @return [Puree::API::CurriculaVitae]
      def curricula_vitae
        Puree::API::CurriculaVitae.new @config
      end

      # @return [Puree::API::Dataset]
      def datasets
        Puree::API::Dataset.new @config
      end

      # @return [Puree::API::Equipment]
      def equipments
        Puree::API::Equipment.new @config
      end

      # @return [Puree::API::Event]
      def events
        Puree::API::Event.new @config
      end

      # @return [Puree::API::ExternalOrganisation]
      def external_organisations
        Puree::API::ExternalOrganisation.new @config
      end

      # @return [Puree::API::ExternalPerson]
      def external_persons
        Puree::API::ExternalPerson.new @config
      end

      # @return [Puree::API::Impact]
      def impacts
        Puree::API::Impact.new @config
      end

      # @return [Puree::API::Journal]
      def journals
        Puree::API::Journal.new @config
      end

      # @return [Puree::API::OrganisationalUnit]
      def organisational_units
        Puree::API::OrganisationalUnit.new @config
      end

      # @return [Puree::API::Person]
      def persons
        Puree::API::Person.new @config
      end

      # @return [Puree::API::PressMedia]
      def press_media
        Puree::API::PressMedia.new @config
      end

      # @return [Puree::API::Prize]
      def prizes
        Puree::API::Prize.new @config
      end

      # @return [Puree::API::Project]
      def projects
        Puree::API::Project.new @config
      end

      # @return [Puree::API::Publisher]
      def publishers
        Puree::API::Publisher.new @config
      end

      # @return [Puree::API::ResearchOutput]
      def research_outputs
        Puree::API::ResearchOutput.new @config
      end
    end
  end
end
