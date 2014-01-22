Q       = require('q')
_       = require("lodash")
request = require('request')

responseIsOk = (error, response) -> !error && response && response['statusCode'] != 200

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
      defer.reject new Error(error) if responseIsOk(error, response)

      defer.resolve body

    defer.promise

  repos: -> @request().then (repos) ->
    @repositories = repos if repos.length

    _.pluck(@repositories, "repository")

module.exports = BlackListApi
