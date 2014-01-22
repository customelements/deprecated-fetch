Q       = require('q')
_       = require("lodash")
request = require('request')

class BlackListApi
  constructor: (@apiUrl = "") ->
    @repositories = []

  request: ->
    defer = Q.defer()
    options =
      uri: @apiUrl
      json: true

    request options, (error, response, body) ->
      defer.reject new Error(error) if error
      defer.reject new Error(error) if !error && response.statusCode != 200

      defer.resolve body

    defer.promise

  repos: -> @request().then (repos) ->
    @repositories = repos if repos.length

    _.pluck(@repositories, "repository")

module.exports = BlackListApi
