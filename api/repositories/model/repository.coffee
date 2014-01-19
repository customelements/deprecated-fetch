BLANK_REPO =
  name: ""
  ownerUsername: ""
  url: ""
  description: ""
  totalForks: 0
  totalStars: 0


class Repository
  constructor: (repository = BLANK_REPO) ->
    @name          = repository.name
    @ownerUsername = repository.ownerUsername
    @url           = repository.url
    @description   = repository.description
    @totalForks    = repository.totalForks
    @totalStars    = repository.totalStars

module.exports = Repository
