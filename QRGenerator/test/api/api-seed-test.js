var app = require('../../api');
var request = require('supertest');
var should = require('chai').should();
var assert = require('assert');

// todo: ES6
// todo: separated test db

function requestJson (verb, url) {
  return request(app)[verb](url)
  .set('Content-Type', 'application/json')
  .set('Accept', 'application/json')
  .expect('Content-Type', /json/);
}

describe('API Seed Test', function () {
  it('GET /seed should generate a random seed with an expire date', function (done) {
    requestJson('get', '/seed')
    .expect(200)
    .end(function (err, res) {
      try {
        var data = res.body.data;
        var expiredAt = res.body.expiredAt;

        data.should.be.a('string');
        data.should.have.length(32);

        expiredAt.should.be.a('number');
        expiredAt.toString().should.have.length(13);

        new Date(expiredAt).getTime().toString().should.have.length(13);

        done();
      } catch (e) {
        return done(e);
      }
    });
  });
});