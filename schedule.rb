require 'net/http'
require './spider_new'
require './request'
require '../spider/unique_request'
class Schedule
  def initialize
    @redis = Redis::new
    @enumeric_basic = 0
  end
  #接受传过来的参数,以及对请求对象进行去重
  # 接受传过来的url等各种参数, 进行request对象的封装,使其实现get, post方法
  def self.generate_start_request
      Spider_new::url_pipeline.each  do |url|
      request_new = Request.new url
      self.add_request request_new
  end
  end
  def self.add_request request
    #向redis中添加request对象
    unique = Unique_request.new
    unique.unique_request request
  end
  def get_request
     sleep 1 until @redis.zcard('request').to_i > @enumeric_basic
     begin
      arrary_new = @redis.zrange('request',@enumeric_basic+=1, @enumeric_basic)[0].split('_')
     rescue Exception=>e
      puts e
     else
      print "url : ";puts"#{ Base64::decode64 arrary_new[0]}" if !arrary_new[0].nil?
      print "method : "; puts"#{ Base64::decode64 arrary_new[1]}" if !arrary_new[1].nil?
      print "data :";puts " #{ Base64::decode64 arrary_new[2]}" if !arrary_new[2].nil?
      request = Request.new arrary_new[0], request_method=arrary_new[1],data = arrary_new[2]
    end
  end
end
Schedule.generate_start_request
schedue = Schedule.new

6.times do
  schedue.get_request
end

