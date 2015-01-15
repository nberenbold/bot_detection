require 'action_controller'
require 'action_view'
require "public_suffix"

module BotDetection
end

require 'bot_detection/version'
require 'bot_detection/controller_helper'
require 'bot_detection/detector'

ActionController::Base.send :include, BotDetection::ControllerHelper