require 'puree/api/mixins/active_mixin'
require 'puree/api/mixins/activity_mixin'
require 'puree/api/mixins/application_mixin'
require 'puree/api/mixins/award_mixin'
require 'puree/api/mixins/dataset_mixin'
require 'puree/api/mixins/former_mixin'
require 'puree/api/mixins/impact_mixin'
require 'puree/api/mixins/person_mixin'
require 'puree/api/mixins/press_media_mixin'
require 'puree/api/mixins/prize_mixin'
require 'puree/api/mixins/project_mixin'
require 'puree/api/mixins/research_output_mixin'
require 'puree/api/mixins/student_thesis_mixin'

module Puree

  module API

    # Requests for the Organisational Unit resource
    #
    class OrganisationalUnit < Puree::API::Base
      include Puree::API::ActiveMixin
      include Puree::API::ActivityMixin
      include Puree::API::ApplicationMixin
      include Puree::API::AwardMixin
      include Puree::API::DatasetMixin
      include Puree::API::FormerMixin
      include Puree::API::ImpactMixin
      include Puree::API::PersonMixin
      include Puree::API::PressMediaMixin
      include Puree::API::PrizeMixin
      include Puree::API::ProjectMixin
      include Puree::API::ResearchOutputMixin
      include Puree::API::StudentThesisMixin

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      private

      def collection
        'organisational-units'
      end

    end

  end

end
