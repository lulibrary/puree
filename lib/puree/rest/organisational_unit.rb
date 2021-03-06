require 'puree/rest/mixins/active_mixin'
require 'puree/rest/mixins/activity_mixin'
require 'puree/rest/mixins/application_mixin'
require 'puree/rest/mixins/award_mixin'
require 'puree/rest/mixins/dataset_mixin'
require 'puree/rest/mixins/former_mixin'
require 'puree/rest/mixins/impact_mixin'
require 'puree/rest/mixins/person_mixin'
require 'puree/rest/mixins/press_media_mixin'
require 'puree/rest/mixins/prize_mixin'
require 'puree/rest/mixins/project_mixin'
require 'puree/rest/mixins/research_output_mixin'
require 'puree/rest/mixins/student_thesis_mixin'

module Puree

  module REST

    # Requests for the Organisational Unit resource
    #
    class OrganisationalUnit < Puree::REST::Base
      include Puree::REST::ActiveMixin
      include Puree::REST::ActivityMixin
      include Puree::REST::ApplicationMixin
      include Puree::REST::AwardMixin
      include Puree::REST::DatasetMixin
      include Puree::REST::FormerMixin
      include Puree::REST::ImpactMixin
      include Puree::REST::PersonMixin
      include Puree::REST::PressMediaMixin
      include Puree::REST::PrizeMixin
      include Puree::REST::ProjectMixin
      include Puree::REST::ResearchOutputMixin
      include Puree::REST::StudentThesisMixin

      private

      def collection
        'organisational-units'
      end

    end

  end

end
