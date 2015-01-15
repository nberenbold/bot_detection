module BotDetection
  module ControllerHelper
    extend ActiveSupport::Concern

    included do
      helper_method :is_known_crawler?, :is_search_engine_crawler?, :is_google?
    end

    def is_known_crawler?
      BotDetection::Detector.is_known_crawler?
    end

    def is_search_engine_crawler? options = {}
      BotDetection::Detector.is_search_engine_crawler?(options)
    end

    def is_google?
      BotDetection::Detector.is_google?
    end
  end
end