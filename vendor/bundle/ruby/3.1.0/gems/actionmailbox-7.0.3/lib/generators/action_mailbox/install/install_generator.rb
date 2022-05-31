# frozen_string_literal: true

require 'rails/generators/mailbox/mailbox_generator'

module ActionMailbox
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root Rails::Generators::MailboxGenerator.source_root

      def create_action_mailbox_files
        say 'Copying application_mailbox.rb to app/mailboxes', :green
        template 'application_mailbox.rb', 'app/mailboxes/application_mailbox.rb'
      end

      def add_action_mailbox_production_environment_config
        environment <<~END_OF_CONFIG, env: 'production'
          # Prepare the ingress controller used to receive mail
          # config.action_mailbox.ingress = :relay

        END_OF_CONFIG
      end

      def create_migrations
        rails_command 'railties:install:migrations FROM=active_storage,action_mailbox', inline: true
      end
    end
  end
end
