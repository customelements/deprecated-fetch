Q           = require('q')
request     = require('request')

requestAPI = (url) ->
  defer = Q.defer()
  options =
    uri: url
    json: true
    headers:
      'User-Agent': 'customelementsio'

  if options.username && options.password
    options.auth =
      username: config.username
      password: config.password

  request options, (error, response, body) ->
    defer.reject new Error(error) if error
    defer.reject new Error("404") if response.statusCode != 200

    defer.resolve body

  defer.promise

class GithubAPI
  constructor: (@config) ->

  repo: (repository) ->
    defer = Q.defer()

    requestAPI("#{@config.apiUrl}#{repository}")
      .then (repo) ->
        defer.resolve repo

      .fail (err) ->
        defer.reject(err)

    defer.promise

module.exports = GithubAPI
