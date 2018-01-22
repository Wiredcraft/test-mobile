'use strict';
module.exports = function(app) {
  var QRGenerator = require('../controllers/QRGeneratorController');

  // QRGenerator Routes

  app.route('/seed')
    .get(QRGenerator.create_seed);
};