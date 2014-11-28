expect        = require('chai').expect
Q             = require('q')
_             = require('lodash')
fs            = require('fs')
path          = require('path')
NPMModulesAPI = projectRequire("api/npm_modules_api")

APIendPoint = "https://skimdb.npmjs.com/registry/_design/app/_view/byKeyword?startkey=[%22web-components%22]&endkey=[%22web-components%22,{}]&group_level=3"

describe "NPM Modules API", ->
  describe "#constructor", ->
    it "creates an instance of NPMModulesAPI", ->
      expect(new NPMModulesAPI()).to.be.instanceOf NPMModulesAPI

  describe "#modules", ->
    m = {}
    before ->
      m.klass = _.clone(NPMModulesAPI)
      m.klass.prototype.request = ->
        defer = Q.defer()
        fs.readFile path.join(__dirname, "..", "fixtures", "api", "npm_modules_api.json"), (err, file) ->
          defer.reject(err) if err
          defer.resolve(JSON.parse(file))

        defer.promise

      m.api = new m.klass("what-ever")

    it "returns the json in a common format", (done) ->
      m.api.modules().then (modules) ->
        expect(modules[0]).eq "voice-elements"
        expect(modules[1]).eq "x-gif"

        done()
      .fail (err) -> done(err)

  describe "#repos", ->
    m = {}

    before ->
      m.klass = _.clone(NPMModulesAPI)
      m.klass.prototype.modules = ->
        defer = Q.defer()
        defer.resolve(['voice-elements', 'x-gif'])
        defer.promise

      m.api = new m.klass(APIendPoint)

    it 'returns the json of all repos in a common format', (done) ->
      m.api.repos().then (repos) ->
        expect(repos[0]).eq "zenorocha/voice-elements"
        expect(repos[1]).eq "geelen/x-gif"

        done()

      .fail (err) -> done(err)

