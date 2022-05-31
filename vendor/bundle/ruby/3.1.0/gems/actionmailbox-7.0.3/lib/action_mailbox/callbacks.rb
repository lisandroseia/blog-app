# frozen_string_literal: true

require 'active_support/callbacks'

module ActionMailbox
  # Defines the callbacks related to processing.
  module Callbacks
    extend ActiveSupport::Concern
    include ActiveSupport::Callbacks

    TERMINATOR = lambda do |mailbox, chain|
      chain.call
      mailbox.finished_processing?
    end

    included do
      define_callbacks :process, terminator: TERMINATOR, skip_after_callbacks_if_terminated: true
    end

    class_methods do
      def before_processing(*methods, &)
        set_callback(:process, :before, *methods, &)
      end

      def after_processing(*methods, &)
        set_callback(:process, :after, *methods, &)
      end

      def around_processing(*methods, &)
        set_callback(:process, :around, *methods, &)
      end
    end
  end
end
