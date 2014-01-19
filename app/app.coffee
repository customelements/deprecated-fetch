express           = require('express')
fetchRepositories = require('./lib/fetch_repositories')

app        = express()
serverPort = process.env.PORT || 3000

app.listen serverPort, ->
  fetchRepositories()
