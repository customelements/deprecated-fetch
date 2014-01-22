express           = require('express')
logfmt            = require('logfmt')
routes            = require('./routes/routes')
ENV               = require("./config/env_vars")

databaseClient    = require("./config/database")
RepositoryHandler = require('./lib/repository_handler')
FetchServiceAPI   = require('./lib/fetch_service_api')

app               = express()
serverPort        = process.env.PORT || 3000

app.use logfmt.requestLogger()

canRun = -> !!(ENV['FETCH_INTERVAL'] && ENV['BOWER_API_URL'] && ENV['CUSTOMELEMENTS_API_URL'])

fetch = ->
  new FetchServiceAPI().repos().then (repos) ->
    new RepositoryHandler(repos).repos()

runFetch = ->
  fetch().then (repos) ->
    saveDB(repos)

    console.log "Repositories updated!"

  .fail (err) ->
    console.log err

saveDB = (repos) ->
  databaseClient.set('repositories', JSON.stringify(repos))

if canRun()
  app.listen serverPort, ->
    routes(app)

    setInterval ->
      runFetch()
    , ENV['FETCH_INTERVAL']

    runFetch()
else
  console.log "I can't fetch repositories, please setup environment vars!"
