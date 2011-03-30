(function() {
  var Mu, brubeck, fs, path, s, template, _i, _len, _ref;
  brubeck = require('brubeck');
  fs = require('fs');
  path = require('path');
  Mu = require('mu');
  Mu.templateRoot = './templates';
  _ref = fs.readdirSync(Mu.templateRoot);
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    template = _ref[_i];
    Mu.compile(path.basename(template), function() {});
  }
  s = brubeck.createServer({
    GET: {
      '/': function() {
        var ctx, write;
        ctx = {
          pageTitle: 'Index',
          foo: 'The main page'
        };
        write = this.write;
        return Mu.render('layout.html', ctx, {}, function(err, out) {
          var buffer;
          if (err) {
            throw err;
          }
          buffer = [];
          out.addListener('data', function(c) {
            return buffer.push(c);
          });
          return out.addListener('end', function() {
            return write(buffer.join(''));
          });
        });
      }
    }
  });
  s.listen(8080);
}).call(this);
