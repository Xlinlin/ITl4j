local key = KEYS[1]
local identifier = ARGV[1]
local lockTimeOut = ARGV[2]

-- 锁定成功
if redis.call("SETNX", key, identifier) == 1 then
    redis.call("EXPIRE", key, lockTimeOut)
    return 1
elseif redis.call("TTL", key) == -1 then
    redis.call("EXPIRE", key, lockTimeOut)
end
return 0
