require 'spec_helper'

class BotDetectionController < ActionController::Base
  def test1
    @bot_detector = BotDetection::Detector.new(user_agent: BotDetection::BotUserAgents.first, remote_ip: "127.0.0.1")
  end

  def test2
    @bot_detector = BotDetection::Detector.new(user_agent: "Googlebot/2.1 (+http://www.googlebot.com/bot.html)", remote_ip: "66.249.66.1")
  end
end

describe BotDetection::ControllerHelper do
  subject { BotDetectionController.new }

  context 'module' do
    it 'should be mixed into ActionController::Base' do
      expect(ActionController::Base.included_modules).to include(BotDetection::ControllerHelper)
    end

    it 'should respond to "is_known_crawler?" helper' do
      expect(subject).to respond_to(:is_known_crawler?)
    end
  end

  context 'returning values' do
    it 'should return false' do
      expect(subject.is_known_crawler?).to eq(false)
    end

    it 'checks if the user is a bot and returns true' do
      subject.test1
      expect(subject.is_known_crawler?).to eq(true)
    end

    it 'should check if the user is google and return true' do
      subject.test2
      expect(subject.is_search_engine_crawler?).to eq(true)
    end

    it 'should return true' do
      subject.test2
      expect(subject.is_google?).to eq(true)
    end
  end
end