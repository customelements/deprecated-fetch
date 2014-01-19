expect    = require('chai').expect
_         = require('lodash')
Q         = require('q')
fs        = require('fs')
path      = require('path')
GithubAPI = projectRequire("api/github_api")

CONFIG =
  apiUrl: "https://api.github.com/repos/"
  username: false
  password: false

describe "Github API", ->
  describe "#constructor", ->
    it "creates an instance of GithubAPI", ->
      expect(new GithubAPI(CONFIG)).to.be.instanceOf GithubAPI

  describe "Properties", ->
    api = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        api = new GithubAPI(CONFIG)

        expect(api[name]).eq value

    expectProperty("config", CONFIG)

  describe "#repo", ->
    it "fail for a invalid url", (done) ->
      api = new GithubAPI(CONFIG)

      api.repo("xxx").fail (err) -> done()

    describe "with Real API URL", ->
      it "returns the full json of repo in github", (done) ->
        api = new GithubAPI(CONFIG)

        api.repo("djalmaaraujo/macbook-bootstrap").then (repo) ->
          expect(repo.id).eq 9842244
          expect(repo.name).eq "macbook-bootstrap"
          expect(repo.full_name).eq "djalmaaraujo/macbook-bootstrap"

          done()

        .fail (err) -> done(err)
