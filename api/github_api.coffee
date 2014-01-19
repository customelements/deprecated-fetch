_           = require('lodash')
Q           = require('q')
request     = require('request')

requestAPI = (options) ->
  defer = Q.defer()
  defaults =
    json: true
    headers:
      'User-Agent': 'customelementsio'

  options = _.assign(defaults, options)

  request options, (error, response, body) ->
    defer.reject new Error(error) if error
    defer.reject new Error("404") if response.statusCode != 200

    defer.resolve body

  defer.promise

class GithubAPI
  constructor: (@config) ->

  repo: (repository) ->
    defer = Q.defer()

    options = @config
    options.uri = "#{@config.apiUrl}#{repository}"

    requestAPI(options)
      .then (repo) ->
        defer.resolve repo

      .fail (err) ->
        defer.reject(err)

    defer.promise

module.exports = GithubAPI
