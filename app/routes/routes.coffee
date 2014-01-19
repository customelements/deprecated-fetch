redisClient = require("../config/database")

module.exports = (app) ->
  app.get "/", (req, res) ->
    redisClient.get 'repositories', (err, repositories) ->
      return false if err

      res.setHeader 'Content-Type', 'text/javascript'
      res.send "var customElements = #{repositories};"
