Q          = require('q')
request    = require('request')
Repository = require("../app/models/repository")

class GithubAPI
  constructor: (@apiUrl = "") ->

  repo: (repository) ->
    defer = Q.defer()

    @request("#{@apiUrl}#{repository}")
      .then (repo) ->
        repository =
          name: repo.name
          ownerUsername: repo.owner.login
          description: repo.description
          totalForks: repo.forks_count
          totalStars: repo.stargazers_count

        defer.resolve(new Repository(repository))

      .fail (err) -> defer.reject(err)

    defer.promise

  request: (url = @apiUrl) ->
    defer = Q.defer()
    options =
      uri: url
      json: true
      headers:
        'User-Agent': 'customelementsio'

    request options, (error, response, body) ->
      defer.reject new Error(error) if error
      defer.reject new Error(error) if !error && response.statusCode != 200

      defer.resolve body

    defer.promise

module.exports = GithubAPI
