require_relative 'user_agents/lookup_domains.rb'
require_relative 'user_agents/google_user_agents.rb'
require_relative 'user_agents/bot_user_agents.rb'
require_relative 'user_agents/search_engine_user_agents.rb'

module BotDetection
  class Detector
    attr_reader :options

    def initialize data = {}
      @options = data
    end

    def is_known_crawler?
      BotDetection::BotUserAgents.include?(user_agent) || is_search_engine_crawler?(reverse_lookup: false)
    end

    def is_search_engine_crawler? options = {}
      return false if remote_ip.blank?

      reverse_lookup = options.delete(:reverse_lookup)
      reverse_lookup = true if reverse_lookup.nil?

      return false unless is_known_search_engine_crawler?
      return true unless reverse_lookup
      return true if options.delete(:development)

      host   = get_hostname(remote_ip)
      return false if host.nil?
      domain = PublicSuffix.parse(host) rescue nil
      return false if domain.nil?

      return false unless BotDetection::LOOKUP_DOMAINS.include?(domain.domain.downcase)
      host_ip = get_hostip(host)
      return false if host_ip.nil?
      host_ip == remote_ip
    end

    def is_google?
      BotDetection::GOOGLE_USER_AGENTS.include?(user_agent)
    end

  protected
    def is_known_search_engine_crawler?
      is_google? || BotDetection::SearchEngineUserAgents.include?(user_agent)
    end

    def get_hostname(ip_address)
      Socket.gethostbyaddr(ip_address.split(".").map(&:to_i).pack("CCCC")).first rescue nil
    end

    def get_hostip(host)
      Socket.gethostbyname(host).last.unpack("C*").join(".") rescue nil
    end

    def remote_ip
      (options[:remote_ip] || options[:remote_addr] || options[:ip] || options[:ip_address]).to_s.strip
    end

    def user_agent
      (options[:env_agent] || options[:user_agent]).to_s.strip
    end
  end
end