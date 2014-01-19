Q       = require('q')
_       = require("lodash")
request = require('request')

class CustomElementsAPI
  constructor: (@apiUrl = "") ->

  repos: -> Q {}

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

  repos: -> @request().then (repos) -> _.pluck(JSON.parse(repos), "repository")

module.exports = CustomElementsAPI
