#代理池, ip池
class Proxy_pool
  #生成proxy
  def initialize
    #初始化
    @f = File.new 'proxy_text', 'r+'
  end
  def generate_proxy
    #返回一个proxy, 每次都是不同的
    begin
      line = @f.readline
      proxy = "协议: #{line.split(' ')[0]}  ip: #{line.split(' ')[1]}"
      if line.match(%r/^\s*$/)
        raise EOFError
      end
    rescue Exception=>e
      @f.close
      @f = File.new 'proxy_text', 'r+'
      line = @f.readline
      proxy = "协议: #{line.split(' ')[0]}  ip: #{line.split(' ')[1]}"
    end
    line.split(' ')
  end
  def generate_new_proxy
    proxy_new = self.generate_proxy
  end
end

class User_Agent_pool
  #生成user-agent
  def initialize
    #初始化
    @f = File.new 'user_agent_text', 'r+'
  end
  def generate_User_Agent
    #返回一个user-agent, 每次都是不同的
    begin
      line = @f.readline
      if line.match(%r/^\s*$/)
        raise EOFError
      end
    rescue Exception=>e
      @f.close
      @f = File.new 'user_agent_text', 'r+'
      line = @f.readline
    end
    line
  end
  def generate_new_User_Agent
    user_agent_new = self.generate_ip
  end
end

class Cookie_pool
  #生成user-agent
  def initialize
    #初始化
    @f = File.new 'cookies_text', 'r+'
  end
  def generate_cookie
    #返回一个user-agent, 每次都是不同的
    begin
      line = @f.readline
      if line.match(%r/^\s*$/)
        raise EOFError
      end
    rescue Exception=>e
      @f.close
      @f = File.new 'cookies_text', 'r+'
      line = @f.readline
    end
    line
  end
  def generate_new_cookie
    user_agent_new = self.generate_ip
  end
end

class Generate_new_request
  def initialize
    @proxy_pool = Proxy_pool.new
    @user_agent_pool = User_Agent_pool.new
    @cookie_pool = Cookie_pool.new
  end
  def generate_new_request request
    request.user_agent = @user_agent_pool.generate_new_User_Agent
    request.cookie = @cookie_pool.generate_new_cookie
    request.proxy = @proxy_pool.generate_new_proxy
    request
  end
end