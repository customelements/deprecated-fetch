BLANK_REPO =
  name: ""
  ownerUsername: ""
  description: ""
  totalForks: 0
  totalStars: 0


class Repository
  constructor: (repository = BLANK_REPO) ->
    @name          = repository.name
    @ownerUsername = repository.ownerUsername
    @url           = @repositoryUrl()
    @description   = repository.description
    @totalForks    = repository.totalForks
    @totalStars    = repository.totalStars

  toJSON: ->
    {
      name: @name
      ownerUsername: @ownerUsername
      url: @url
      description: @description
      totalForks: @totalForks
      totalStars: @totalStars
    }

  repositoryUrl: ->
    "https://github.com/#{@ownerUsername}/#{@name}"

module.exports = Repository
