require "bot_detection/version"
require "public_suffix"

module BotDetection
  def self.included(target)
    target.send(:include, BotDetection::InstanceMethods)
  end
end

require 'bot_detection/instance_methods'

class ActionController::Base
  include BotDetection
end

ActionView::Base.send :include, BotDetection::InstanceMethods