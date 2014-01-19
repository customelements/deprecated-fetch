Q                      = require('q')
_                      = require('lodash')

BowerAPI               = require('../../api/bower_components_api')
CustomElementsAPI      = require('../../api/customelements_api')
FetchAPI               = require('../../api/fetch_api')
GithubAPI              = require('../../api/github_api')
Repository             = require('../models/repository')
redisClient            = require("../config/database")

FETCH_INTERVAL         = process.env.FETCH_INTERVAL || 3600000
BOWER_API_URL          = process.env.BOWER_API_URL || false
CUSTOMELEMENTS_API_URL = process.env.CUSTOMELEMENTS_API_URL || false
GITHUB_API_URL         = process.env.GITHUB_API_URL || false
GITHUB_USERNAME        = process.env.GITHUB_USERNAME || false
GITHUB_PASSWORD        = process.env.GITHUB_PASSWORD || false

githubApi              = new GithubAPI({apiUrl: GITHUB_API_URL, auth: {username: GITHUB_USERNAME, password: GITHUB_PASSWORD}})
bowerApi               = new BowerAPI(BOWER_API_URL)
customElementsApi      = new CustomElementsAPI(CUSTOMELEMENTS_API_URL)

canRun = -> !!(FETCH_INTERVAL && BOWER_API_URL && CUSTOMELEMENTS_API_URL)

iterateRepositories = (reposJson) ->
  promises = iterateApiCalls(reposJson)

  Q.allSettled(promises).then (results) ->
    repos = _.map results, (result) -> parseRepo(result)

    saveRepositories(repos)

parseRepo = (result) ->
  return false unless result.state is "fulfilled"

  repo = result.value
  data =
    name: repo.name
    owner: repo.owner.login
    description: repo.description
    forks: repo.forks_count
    stars: repo.stargazers_count

  new Repository(data).toJSON()

fetchRepositories = ->
  if canRun()
    new FetchAPI(bowerApi.repos(), customElementsApi.repos()).repos().then (repositories) ->
      return false unless repositories

      iterateRepositories(repositories)
  else
    console.log "I can't fetch repositories, please setup environment vars!"

  setTimeout ->
    fetchRepositories()
  , FETCH_INTERVAL

removeInvalidRepositories = (repos) -> _.compact(repos)

saveRepositories = (repos) ->
  filtered = removeInvalidRepositories(repos)

  redisClient.set('repositories', JSON.stringify(filtered))

  console.log "Repositories updated"

iterateApiCalls = (repos) ->
  promises = []

  _.forEach repos, (json) -> promises.push(githubApi.repo(json).delay(3000))
  promises

module.exports = fetchRepositories
