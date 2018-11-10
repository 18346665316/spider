require 'digest/sha1'
require  'redis'
require 'base64'
class Unique_request
  #利用redis有序数组对request进行去重
  def initialize
    @redis = Redis::new
    @enumeric_demo = 0

    # Redis.current = redis
  end
  def get_string request
    url = Base64::encode64(request.url)
    request_method = Base64::encode64(request.request_method)
    data = Base64::encode64(request.data)
    @string_new = [url , request_method, data].join '_'
    # puts @string_new
  end
  def unique_request request
    #将string_new存入到redis的zset中进行去重
    self.get_string request
    @redis.zadd 'request', @enumeric_demo+=@enumeric_demo+1,@string_new
    @redis.commit
    @redis.quit
    # @redis.zrange('request',-1,-1)[0].split('_').each {|st| puts puts Base64::decode64 st}
  end
end
# require './request'
# request = Request.new 'http://www.baidu.com',data = '123'
# unique = Unique_request.new
# unique.unique_request request
