express           = require('express')
BowerAPI          = require('../api/repositories/bower_components_api')
CustomElementsAPI = require('../api/repositories/customelements_api')
FetchAPI          = require('../api/repositories/fetch_api')
fetchRepositories = require('./lib/fetch_repositories')

app        = express()
serverPort = process.env.PORT || 3000

app.listen serverPort, ->
  fetchRepositories()
