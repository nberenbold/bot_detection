require 'bot_detection'
require_relative 'google_user_agents.rb'
require_relative 'bot_user_agents.rb'
require_relative 'search_engine_user_agents.rb'

module BotDetection::InstanceMethods  
  def is_known_crawler?
    BotDetection::BotUserAgents.include?(user_agent) || is_search_engine_crawler?(reverse_lookup: false)
  end
  
  def is_search_engine_crawler? options = {}
    remote_ip = options.delete(:ip) || options.delete(:ip_address) || request.remote_ip
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
    
    return false unless ["crawl.yahoo.net", "googlebot.com", "google.com", "search.msn.com", "ask.com", "yandex.net", "yandex.com", "yandex.ru", "baidu.com", "baidu.jp"].include?(domain.domain.downcase)
    host_ip = get_hostip(host)
    return false if host_ip.nil?
    host_ip = remote_ip
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

  def user_agent
    (request.env['HTTP_USER_AGENT'] || request.user_agent).to_s.strip
  end
end