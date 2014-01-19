expect = require('chai').expect
Repository = projectRequire("api/repositories/model/repository")

describe "Repository", ->
  describe "#constructor", ->
    it "creates a instance of repository", ->
      expect(new Repository()).to.be.an.instanceOf Repository

  describe "Properties", ->
    repo = null

    expectProperty = (name, value = "") ->
      it "expect #{name} property", ->
        repo = new Repository()

        expect(repo[name]).eq value

    expectProperty("name")
    expectProperty("ownerUsername")
    expectProperty("url")
    expectProperty("description")
    expectProperty("totalForks")
    expectProperty("totalStarts")
