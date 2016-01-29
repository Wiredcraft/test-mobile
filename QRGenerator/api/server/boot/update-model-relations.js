module.exports = function (app) {
  app.dataSources.psql.autoupdate(['seed'], function (err) {
    if (err) throw err;
    console.log('All Models Auto Updated.');
  });
};
