Q       = require('q')
_       = require("lodash")
request = require('request')

class BowerComponentsAPI
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

  repos: -> @request().then (repos) ->

    _.map repos, (result) -> result.website.replace("https://github.com/", "")

module.exports = BowerComponentsAPI
