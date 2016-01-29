var crypto = require('crypto');

module.exports = function (Seed) {
  Seed.disableRemoteMethod('create', true);
  Seed.disableRemoteMethod('upsert', true);
  Seed.disableRemoteMethod('exists', true);
  Seed.disableRemoteMethod('findById', true);
  Seed.disableRemoteMethod('find', true);
  Seed.disableRemoteMethod('findOne', true);
  Seed.disableRemoteMethod('deleteById', true);
  Seed.disableRemoteMethod("updateAttributes", false);
  Seed.disableRemoteMethod('count', true);
  Seed.disableRemoteMethod('createChangeStream', true);
  Seed.disableRemoteMethod('updateAll', true);

  Seed.getNewSeed = function (cb) {
    Seed.create({
      data: crypto.randomBytes(16).toString('hex'),
      expiredAt: new Date(new Date().getTime() + 60 * 1000).getTime()
    }, function (err, createdSeed) {
      if (err) {
        console.log(err);
        return;
      }

      cb(null, {
        data: createdSeed.data,
        expiredAt: new Date(createdSeed.expiredAt).getTime()
      });
    })
  };

  Seed.remoteMethod(
    'getNewSeed',
    {
      description: 'GET new seed. actually this HTTP verb should be POST, nevermind.',
      http: {
        path: '/',
        verb: 'get'
      },
      returns: {
        arg: 'data',
        type: 'seed',
        root: true
      }
    }
  );
};
