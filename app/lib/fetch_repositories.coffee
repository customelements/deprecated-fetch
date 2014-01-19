BowerAPI          = require('../../api/bower_components_api')
CustomElementsAPI = require('../../api/customelements_api')
FetchAPI          = require('../../api/fetch_api')

FETCH_INTERVAL         = process.env.FETCH_INTERVAL || 20000
BOWER_API_URL          = process.env.API_BOWER_URL || false
CUSTOMELEMENTS_API_URL = process.env.API_CUSTOMELEMENTS_URL || false

canRun = -> !!(FETCH_INTERVAL && BOWER_API_URL && CUSTOMELEMENTS_API_URL)

fetchRepositories = ->
  if canRun()
    bower          = new BowerAPI(BOWER_API_URL)
    customElements = new CustomElementsAPI(CUSTOMELEMENTS_API_URL)

    new FetchAPI(bower.repos(), customElements.repos()).repos().then (repositories) ->
      if repositories
        fetchTimes++

        console.log "Repositories updated."
  else
    console.log "I can't fetch repositories, please setup environment vars!"

  setTimeout ->
    fetchRepositories()
  , FETCH_INTERVAL

module.exports = fetchRepositories
