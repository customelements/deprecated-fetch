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
    expectProperty("url", "https://github.com//")
    expectProperty("description")
    expectProperty("totalForks", 0)
    expectProperty("totalStars", 0)

  describe "#toJSON", ->
    it "expect to return the repository as a json", ->
      repository =
        name: "fetch-service"
        ownerUsername: "customelements"
        url: "https://github.com/customelements/fetch-service"
        description: "Some description"
        totalForks: 20
        totalStars: 10

      repo = new Repository(repository)
      json = repo.toJSON()

      expect(json.name).eq repository.name
      expect(json.ownerUsername).eq repository.ownerUsername
      expect(json.url).eq repository.url
      expect(json.description).eq repository.description
      expect(json.totalForks).eq repository.totalForks
      expect(json.totalStars).eq repository.totalStars

  describe "#repositoryUrl", ->
    repository =
        name: "fetch-service"
        ownerUsername: "customelements"
        description: ""
        totalForks: 0
        totalStars: 0

    it "returns github repository url", ->
      repo = new Repository(repository)

      expect(repo.repositoryUrl()).eq "https://github.com/#{repository.ownerUsername}/#{repository.name}"
