BLANK_REPO =
  name: ""
  ownerUsername: ""
  url: ""
  description: ""
  totalForks: ""
  totalStarts: ""


class Repository
  constructor: (repository = BLANK_REPO) ->
    @name          = repository.name
    @ownerUsername = repository.ownerUsername
    @url           = repository.url
    @description   = repository.description
    @totalForks    = repository.totalForks
    @totalStarts   = repository.totalStarts

module.exports = Repository
