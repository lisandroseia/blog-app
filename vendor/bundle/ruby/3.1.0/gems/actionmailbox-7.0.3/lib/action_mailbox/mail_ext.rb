# frozen_string_literal: true

require 'mail'

# The hope is to upstream most of these basic additions to the Mail gem's Mail object. But until then, here they lay!
Dir["#{__dir__}/mail_ext/*"].each do |path|
  require "action_mailbox/mail_ext/#{File.basename(path)}"
end
