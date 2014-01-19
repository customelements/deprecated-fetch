require("coffee-script");

var path,
  __slice = [].slice;

path = require("path");

global.projectRequire = function() {
  var buildPath, module, modules, _i, _len, _results;
  modules = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
  buildPath = function(m) {
    return path.join(__dirname, "..", m);
  };
  if (modules.length === 1) {
    return require(buildPath(modules[0]));
  } else {
    _results = [];
    for (_i = 0, _len = modules.length; _i < _len; _i++) {
      module = modules[_i];
      _results.push(require(buildPath(module)));
    }
    return _results;
  }
};