module Puree

  module REST

    # Requests for all resources
    #
    class Client

      # @option (see Puree::REST::Base#initialize)
      def initialize(config)
        @config = config
      end

      # @return [Puree::REST::Activity]
      def activities
        Puree::REST::Activity.new @config
      end

      # @return [Puree::REST::Application]
      def applications
        Puree::REST::Application.new @config
      end

      # @return [Puree::REST::ClassificationScheme]
      def classification_schemes
        Puree::REST::ClassificationScheme.new @config
      end

      # @return [Puree::REST::CurriculaVitae]
      def curricula_vitae
        Puree::REST::CurriculaVitae.new @config
      end

      # @return [Puree::REST::Dataset]
      def datasets
        Puree::REST::Dataset.new @config
      end

      # @return [Puree::REST::Equipment]
      def equipments
        Puree::REST::Equipment.new @config
      end

      # @return [Puree::REST::Event]
      def events
        Puree::REST::Event.new @config
      end

      # @return [Puree::REST::ExternalOrganisation]
      def external_organisations
        Puree::REST::ExternalOrganisation.new @config
      end

      # @return [Puree::REST::ExternalPerson]
      def external_persons
        Puree::REST::ExternalPerson.new @config
      end

      # @return [Puree::REST::Impact]
      def impacts
        Puree::REST::Impact.new @config
      end

      # @return [Puree::REST::Journal]
      def journals
        Puree::REST::Journal.new @config
      end

      # @return [Puree::REST::OrganisationalUnit]
      def organisational_units
        Puree::REST::OrganisationalUnit.new @config
      end

      # @return [Puree::REST::Person]
      def persons
        Puree::REST::Person.new @config
      end

      # @return [Puree::REST::PressMedia]
      def press_media
        Puree::REST::PressMedia.new @config
      end

      # @return [Puree::REST::Prize]
      def prizes
        Puree::REST::Prize.new @config
      end

      # @return [Puree::REST::Project]
      def projects
        Puree::REST::Project.new @config
      end

      # @return [Puree::REST::Publisher]
      def publishers
        Puree::REST::Publisher.new @config
      end

      # @return [Puree::REST::ResearchOutput]
      def research_outputs
        Puree::REST::ResearchOutput.new @config
      end
    end
  end
end
