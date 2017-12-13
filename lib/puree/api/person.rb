require 'puree/api/mixins/active_mixin'
require 'puree/api/mixins/activity_mixin'
require 'puree/api/mixins/application_mixin'
require 'puree/api/mixins/award_mixin'
require 'puree/api/mixins/dataset_mixin'
require 'puree/api/mixins/former_mixin'
require 'puree/api/mixins/impact_mixin'
require 'puree/api/mixins/press_media_mixin'
require 'puree/api/mixins/prize_mixin'
require 'puree/api/mixins/project_mixin'
require 'puree/api/mixins/research_output_mixin'
require 'puree/api/mixins/student_thesis_mixin'

module Puree

  module API

    # Requests for the Person resource
    #
    # @note :id can be UUID, ID, Employee ID or HESA Staff ID
    class Person < Puree::API::Base
      include Puree::API::ActiveMixin
      include Puree::API::ActivityMixin
      include Puree::API::ApplicationMixin
      include Puree::API::AwardMixin
      include Puree::API::DatasetMixin
      include Puree::API::FormerMixin
      include Puree::API::ImpactMixin
      include Puree::API::PressMediaMixin
      include Puree::API::PrizeMixin
      include Puree::API::ProjectMixin
      include Puree::API::ResearchOutputMixin
      include Puree::API::StudentThesisMixin

      # @option (see Puree::API::Base#initialize)
      def initialize(config)
        super
      end

      # (see Puree::API::Base#find)
      def curricula_vitae(id:, params: {}, accept: :xml)
        get_request_singleton_subcollection(id: id,
                                         subcollection: 'curricula-vitae',
                                         params: params,
                                         accept: accept)
      end

      private

      def collection
        'persons'
      end

    end

  end

end
