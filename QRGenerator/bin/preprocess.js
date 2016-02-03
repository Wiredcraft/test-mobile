#!/bin/node

var pp = require('preprocess');

var file = './app/manifests/env.js.preprocess';
var fileName = file.replace(/\.preprocess/, '');
var context = {
  API_HOST: process.env.API_HOST || 'http://localhost:8090',
};

pp.preprocessFileSync(file, fileName, context, {
  type: 'js'
});

console.log('Set ENV preprocess: saved to app/manifests/' + fileName);
