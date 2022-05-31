# frozen_string_literal: true

module ActionDispatch
  module Routing
    class Endpoint # :nodoc:
      def dispatcher?() = false
      def redirect?() = false
      def matches?(_req) = true
      def app() = self
      def rack_app() = app

      def engine?
        rack_app.is_a?(Class) && rack_app < Rails::Engine
      end
    end
  end
end
