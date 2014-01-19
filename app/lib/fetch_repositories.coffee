Q     = require('q')
_     = require('lodash')

BowerAPI          = require('../../api/bower_components_api')
CustomElementsAPI = require('../../api/customelements_api')
FetchAPI          = require('../../api/fetch_api')
GithubAPI         = require('../../api/github_api')
Repository        = require('../models/repository')
redisClient       = require("../config/database")

FETCH_INTERVAL         = process.env.FETCH_INTERVAL || 3600000
BOWER_API_URL          = process.env.BOWER_API_URL || false
CUSTOMELEMENTS_API_URL = process.env.CUSTOMELEMENTS_API_URL || false

githubApi   = new GithubAPI()

canRun = -> !!(FETCH_INTERVAL && BOWER_API_URL && CUSTOMELEMENTS_API_URL)

fetchRepositories = ->
  if canRun()
    bower          = new BowerAPI(BOWER_API_URL)
    customElements = new CustomElementsAPI(CUSTOMELEMENTS_API_URL)

    new FetchAPI(bower.repos(), customElements.repos()).repos().then (repositories) ->
      if repositories
        parseJsonFrom(repositories)
  else
    console.log "I can't fetch repositories, please setup environment vars!"

  setTimeout ->
    fetchRepositories()
  , FETCH_INTERVAL

parseJsonFrom = (reposJson) ->
  repositories = []
  promises     = []

  _.forEach reposJson, (json) ->
    promises.push(githubApi.repo(json).delay(3000))

  Q.allSettled(promises).then (results) ->
    total = results.length
    repos = _.map results, (result) ->
      if result.state is "fulfilled"
        repo = result.value
        data =
          name: repo.name
          owner: repo.owner.login
          description: repo.description
          forks: repo.forks_count
          stars: repo.stargazers_count

        new Repository(data).toJSON()

    redisClient.set('repositories', JSON.stringify(repos))

    console.log "Repositories updated."

module.exports = fetchRepositories
