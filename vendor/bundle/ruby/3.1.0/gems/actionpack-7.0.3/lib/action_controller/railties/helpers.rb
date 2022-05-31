# frozen_string_literal: true

module ActionController
  module Railties
    module Helpers
      def inherited(klass)
        super
        return unless klass.respond_to?(:helpers_path=)

        paths = if namespace = klass.module_parents.detect { |m| m.respond_to?(:railtie_helpers_paths) }
                  namespace.railtie_helpers_paths
                else
                  ActionController::Helpers.helpers_path
                end

        klass.helpers_path = paths

        klass.helper :all if klass.superclass == ActionController::Base && ActionController::Base.include_all_helpers
      end
    end
  end
end
