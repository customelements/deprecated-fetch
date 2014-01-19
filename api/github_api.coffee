Q           = require('q')
request     = require('request')

API_URL = "https://api.github.com/repos/"

requestAPI = (url) ->
  defer = Q.defer()
  options =
    uri: url
    json: true
    headers:
      'User-Agent': 'customelementsio'

  request options, (error, response, body) ->
    defer.reject new Error(error) if error
    defer.reject new Error("404") if response.statusCode != 200

    defer.resolve body

  defer.promise

class GithubAPI
  constructor: ->

  repo: (repository) ->
    defer = Q.defer()

    requestAPI("#{API_URL}#{repository}")
      .then (repo) ->
        defer.resolve repo

      .fail (err) ->
        defer.reject(err)

    defer.promise

module.exports = GithubAPI
