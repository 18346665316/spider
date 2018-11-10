require 'net/http'
class Request
  #构造request对象
  # 让其具有cookie, user_agent, proxy属性
  # 传去到中间件中进行填充
  attr_accessor :proxy, :user_agent, :cookie, :url, :request_method, :data
  def initialize(url, request_method = 'get', proxy = '', user_agent = '', cookie = '', data = '')
    @url = url
    @proxy = proxy
    @user_agent = user_agent
    @cookie = cookie
    @data = data
    @request_method = request_method
  end
end