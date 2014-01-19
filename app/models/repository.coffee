BLANK_REPO =
  name: ""
  owner: ""
  description: ""
  forks: 0
  stars: 0

PREFIX = "https://github.com/"

class Repository
  constructor: (repository = BLANK_REPO) ->
    @name        = repository.name
    @owner       = repository.owner
    @url         = @repositoryUrl()
    @owner_url   = @ownerUrl()
    @description = repository.description
    @forks       = repository.forks
    @stars       = repository.stars

  toJSON: ->
    {
      name: @name
      owner: @owner
      url: @repositoryUrl()
      owner_url: @ownerUrl()
      description: @description
      forks: @forks
      stars: @stars
    }

  repositoryUrl: ->
    "#{PREFIX}#{@owner}/#{@name}"

  ownerUrl: ->
    "#{PREFIX}#{@owner}"

module.exports = Repository
