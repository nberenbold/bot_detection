require 'bot_detection'
require_relative 'google_user_agents.rb'

module BotDetection::InstanceMethods  
  def is_search_engine_crawler? options = {}
    remote_ip = options.delete(:ip) || options.delete(:ip_address) || request.remote_ip
    return false if remote_ip.blank? || (!is_google? && !is_yahoo? && !is_msn? && !is_bing?)

    return true if options.delete(:development)

    found = false
    host = get_hostname(remote_ip)
    ["crawl.yahoo.net", "googlebot", "search.msn.com", "ask.com"].each do |h|
      found = true and break if host.include?(h)
    end

    return false unless found
    
    host_ip = get_hostip(host)
    return host_ip == remote_ip
    false
  end

  def is_google?
    BotDetection::GOOGLE_USER_AGENTS.include?(request.env['HTTP_USER_AGENT']) || request.user_agent.to_s.downcase.include?("googlebot")
  end
  
  def is_yahoo?
    request.user_agent.to_s.downcase.include?("yahoo! slurp")
  end
  
  def is_msn?
    request.user_agent.to_s.downcase.include?("msnbot")
  end
  
  def is_bing?
    request.user_agent.to_s.downcase.include?("bing")
  end
  
  def get_hostname(ip_address)
    Socket.gethostbyaddr(ip_address.split(".").map(&:to_i).pack("CCCC")).first
  end
  
  def get_hostip(host)
    Socket.gethostbyname(host).last.unpack("C*").join(".")    
  end
end