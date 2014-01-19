expect = require('chai').expect
FetchAPI = projectRequire("api/repositories/fetch_api")

describe "Fetch API", ->
  describe "#constructor", ->
    it "creates an instance of FetchAPI", ->
      expect(new FetchAPI()).to.be.instanceOf FetchAPI
