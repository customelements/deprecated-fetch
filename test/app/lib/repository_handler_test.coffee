Q                 = require('q')
_                 = require('lodash')
expect            = require('chai').expect
fs                = require('fs')
path              = require('path')
RepositoryHandler = projectRequire('app/lib/repository_handler')
Repository        = projectRequire('app/models/repository')

describe "Repository Fetch", ->
  describe "#constructor", ->
    it "creates an instance of BlackListApi", ->
      expect(new RepositoryHandler()).to.be.instanceOf RepositoryHandler

    it "receives repositories as param", ->
      handler = new RepositoryHandler([1,2,3])
      expect(handler.repositories.length).eq 3

  describe "Api calls", ->
    memo = {}

    beforeEach ->
      memo.klass = _.clone(RepositoryHandler)
      memo.handler = new memo.klass(['djalmaaraujo/macbook-bootstrap'])
      memo.handler.repositories = memo.repositories
      memo.handler.githubApi =
        repo: (json) ->
          defer = Q.defer()
          fs.readFile path.join(__dirname, "..", "..", "fixtures", "app", "lib", "repository.json"), (err, file) ->
            defer.reject(err) if err
            defer.resolve(JSON.parse(file))

          defer.promise

    describe "#fetchRepo", ->
      it "returns a repo json from github api", (done) ->
        memo.handler.fetchRepo('djalmaaraujo/macbook-bootstrap').then (repoJson) ->
          expect(repoJson.name).eq "macbook-bootstrap"
          expect(repoJson.watchers_count).eq 13
          expect(repoJson.forks).eq 4

          done()

        .fail (err) -> done(err)

    describe "#iterateApiCalls", ->
      it "returns a array of promises", ->
        memo.handler.iterateApiCalls()

        expect(memo.handler.apiCalls.length).eq 1

    describe "#isFulfilled", ->
      it "expect to return true for a obejct with state param as fulfilled", ->
        expect(memo.handler.isFulfilled(state: "fulfilled")).true

    describe "#parseRepo", ->
      it "return a json as a Repository object", (done) ->
        memo.handler.fetchRepo('xxx').then (repo) ->
          parsedRepo = memo.handler.parseRepo(repo)

          expect(parsedRepo.name).eq "macbook-bootstrap"
          expect(parsedRepo.forks).eq 4
          expect(parsedRepo.stars).eq 13

          done()

        .fail (err) -> done(err)
