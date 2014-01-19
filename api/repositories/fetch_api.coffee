_ = require('lodash')
Q = require('q')

class FetchAPI
  constructor: (@sources...) ->

  repos: -> Q.all(@sources).then (repos) -> _.flatten(repos)

module.exports = FetchAPI
