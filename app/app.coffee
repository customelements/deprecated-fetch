express           = require('express')
logfmt            = require('logfmt')
fetchRepositories = require('./lib/fetch_repositories')
routes            = require('./routes/routes')

app        = express()
serverPort = process.env.PORT || 3000

app.use logfmt.requestLogger()

app.listen serverPort, ->
  routes(app)

  fetchRepositories()
