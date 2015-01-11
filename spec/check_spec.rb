require 'spec_helper'

describe BotDetection::InstanceMethods do
  context 'returning values' do
    it 'should return title' do
      expect(is_google?).to false
    end
  end
end