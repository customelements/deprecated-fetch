Q           = require('q')
_           = require("lodash")
request     = require('request')
AbstractAPI = require('./abstracts/abstract_api')

class BowerComponentsAPI extends AbstractAPI
  repos: -> @request().then (repos) ->
    _.map repos, (result) -> result.website.replace("https://github.com/", "")

module.exports = BowerComponentsAPI
