module.exports = function (app) {
  app.dataSources.psql.automigrate(['seed'], function (err) {
    if (err) throw err;
    console.log('All Models Auto Updated.');
  });
};
