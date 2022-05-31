# frozen_string_literal: true

module ActionDispatch
  # Provides callbacks to be executed before and after dispatching the request.
  class Callbacks
    include ActiveSupport::Callbacks

    define_callbacks :call

    class << self
      def before(*args, &)
        set_callback(:call, :before, *args, &)
      end

      def after(*args, &)
        set_callback(:call, :after, *args, &)
      end
    end

    def initialize(app)
      @app = app
    end

    def call(env)
      error = nil
      result = run_callbacks :call do
        @app.call(env)
      rescue StandardError => e
      end
      raise error if error

      result
    end
  end
end
