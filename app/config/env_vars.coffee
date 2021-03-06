env = (index) -> process.env[index]

vars =
  FETCH_INTERVAL: env('FETCH_INTERVAL') || 1800000
  BOWER_API_URL: env('BOWER_API_URL') || false
  BLACKLIST_API_URL: env('BLACKLIST_API_URL') || false
  CUSTOMELEMENTS_API_URL: env('CUSTOMELEMENTS_API_URL') || false
  NPM_API_URL: env('NPM_API_URL') || false
  GITHUB_API_URL: env('GITHUB_API_URL') || false
  GITHUB_USERNAME: env('GITHUB_USERNAME') || false
  GITHUB_PASSWORD: env('GITHUB_PASSWORD') || false

module.exports = vars
