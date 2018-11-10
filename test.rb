require 'redis'
redis = Redis::new
redis.zadd 'request_1', 1, 'name'
redis.commit
redis.quit