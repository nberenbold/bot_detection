module BotDetection
  module ControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :is_known_crawler?, :is_search_engine_crawler?, :is_google?
    end

    def is_known_crawler?
      bot_detector.is_known_crawler?
    end

    def is_search_engine_crawler? options = {}
      bot_detector.is_search_engine_crawler?(options)
    end

    def is_google?
      bot_detector.is_google?
    end

    def bot_detector
      return (@bot_detector || BotDetection::Detector.new) if request.nil?
      @bot_detector ||= BotDetection::Detector.new(
        user_agent: request.user_agent,
        env_agent: request.env['HTTP_USER_AGENT'],
        remote_ip: request.remote_ip
      )
    end
  end
end