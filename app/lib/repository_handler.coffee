_          = require('lodash')
Q          = require('q')
GithubAPI  = require('../../api/github_api')
Repository = require('../models/repository')
ENV        = require("../config/env_vars")

DELAY_TIME      = 3000

removeInvalid = (repos) -> _.compact(repos)
toJSON        = (repo) -> new Repository(repo).toJSON()

class RepositoryHandler
  constructor: (@repositories) ->
    @apiCalls = []
    @githubApi = new GithubAPI({apiUrl: ENV['GITHUB_API_URL'], auth: {username: ENV['GITHUB_USERNAME'], password: ENV['GITHUB_PASSWORD']}})
    @iterateApiCalls()

  iterateApiCalls: -> _.forEach @repositories, (json) => @apiCalls.push(@fetchRepo(json))

  fetchRepo: (json) -> @githubApi.repo(json)

  repos: ->
    Q.allSettled(@apiCalls).then (results) =>
      repos = @parseResults(results)

      removeInvalid(repos)

    .fail (err) -> new Error(err)

  parseResults: (results) =>
    _.map results, (result) =>
      return false unless @isFulfilled(result)

      @parseRepo(result.value) if @isFulfilled(result)

  isFulfilled: (result) -> result.state == "fulfilled"

  parseRepo: (repo) ->
    toJSON
      name: repo.name
      owner: repo.owner.login
      description: repo.description
      forks: repo.forks_count
      stars: repo.stargazers_count

module.exports = RepositoryHandler
