(function() {
  var Reporter, b, exponent, fs, hash, index, iterations, n, reporter, size, stream, target_index, timeit;
  fs = require('fs');
  timeit = require('timeit');
  b = require('b');
  iterations = 10000;
  Reporter = (function() {
    function Reporter() {
      this.data = [];
    }
    Reporter.prototype.report = function(name, result, iterations) {
      console.log("retrieving an element from a hash with " + size + " elements " + iterations + " times tooks " + result + " ms");
      return this.data.push(result);
    };
    return Reporter;
  })();
  reporter = new Reporter;
  for (exponent = 1; exponent <= 20; exponent++) {
    size = Math.pow(2, exponent);
    hash = {};
    target_index = 0;
    for (n = 1; 1 <= size ? n <= size : n >= size; 1 <= size ? n++ : n--) {
      index = Math.random();
      hash[index] = Math.random();
      if (n === size / 2) {
        target_index = index;
      }
    }
    b('Read Test').reporter(reporter).run(iterations, function() {
      var val;
      return val = hash[target_index];
    });
  }
  stream = fs.createWriteStream("values.node-" + process.versions.node);
  stream.once('open', function(fd) {
    var val, _i, _len, _ref, _results;
    _ref = reporter.data;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      val = _ref[_i];
      _results.push(stream.write("" + val + "\n"));
    }
    return _results;
  });
}).call(this);
