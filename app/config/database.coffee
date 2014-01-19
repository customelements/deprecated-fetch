redis = require("redis")
url   = require('url')
env = process.env

redisConfig = url.parse(process.env.REDISTOGO_URL)

redisClient = redis.createClient(redisConfig.port, redisConfig.hostname)
auth = redisConfig.auth.split(":")

redisClient.auth(auth[1])

module.exports = redisClient
