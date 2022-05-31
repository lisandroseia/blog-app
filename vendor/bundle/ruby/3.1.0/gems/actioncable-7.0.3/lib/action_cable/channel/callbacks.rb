require 'active_support/callbacks'

module ActionCable
  module Channel
    module Callbacks
      extend ActiveSupport::Concern
      include ActiveSupport::Callbacks

      included do
        define_callbacks :subscribe
        define_callbacks :unsubscribe
      end

      module ClassMethods
        def before_subscribe(*methods, &)
          set_callback(:subscribe, :before, *methods, &)
        end

        def after_subscribe(*methods, &)
          set_callback(:subscribe, :after, *methods, &)
        end
        alias on_subscribe after_subscribe

        def before_unsubscribe(*methods, &)
          set_callback(:unsubscribe, :before, *methods, &)
        end

        def after_unsubscribe(*methods, &)
          set_callback(:unsubscribe, :after, *methods, &)
        end
        alias on_unsubscribe after_unsubscribe
      end
    end
  end
end
