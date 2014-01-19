expect    = require('chai').expect
_         = require('lodash')
Q         = require('q')
fs        = require('fs')
path      = require('path')
GithubAPI = projectRequire("api/github_api")

describe "Github API", ->
  describe "#constructor", ->
    it "creates an instance of GithubAPI", ->
      expect(new GithubAPI()).to.be.instanceOf GithubAPI

  describe "#repo", ->
    it "fail for a invalid url", (done) ->
      api = new GithubAPI()

      api.repo("xxx").fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repo in github", (done) ->
        api = new GithubAPI()

        api.repo("djalmaaraujo/macbook-bootstrap").then (repo) ->
          expect(repo.id).eq 9842244
          expect(repo.name).eq "macbook-bootstrap"
          expect(repo.full_name).eq "djalmaaraujo/macbook-bootstrap"

          done()

        .fail (err) -> done(err)
