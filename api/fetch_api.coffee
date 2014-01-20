_ = require('lodash')
Q = require('q')

removeMatches = (options, exclude) -> _.difference(options, exclude)

class FetchAPI
  constructor: (@sources...) ->

  repos: (params = {}) ->
    Q.all(@sources).then (result) ->
      repos = _.uniq(_.flatten(result))
      repos = removeMatches(repos, params.exclude) if params.exclude

      repos

module.exports = FetchAPI
