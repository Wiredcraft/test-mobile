(function() {
  var path = require('path');
  var webpack = require('webpack');

  module.exports = {
    debug: true,
    devtool: 'source-map',
    entry: {
      'index.ios': ['./app/main.ios.js']
    },
    output: {
      path: path.resolve(__dirname, 'build'),
      filename: '[name].js',
    },
    resolve: {
      extensions: ["", ".webpack.js", ".js", ".web.js", ".ios.js"]
    },
    module: {
      preLoaders: [
        {
          test: /\.(js|jsx|es6)$/,
          include: path.resolve(__dirname, 'app'),
          loader: 'eslint-loader',
        }
      ],
      loaders: [
        {
          test: /\.js$/,
          include: [
            /node_modules\/react-native/,
            /node_modules\/@exponent/,
            /node_modules\/react-native-camera/,
            /node_modules\/react-native-material-kit/
          ],
          loader: 'babel',
          query: {
            cacheDirectory: true,
            presets: ['es2015', 'stage-0', 'react']
          }
        },
        {
          test: /\.(js|jsx|es6)$/,
          exclude: /node_modules/,
          loader: 'babel',
          query: {
            cacheDirectory: true,
            presets: ['es2015', 'stage-0', 'react']
          }
        }
      ]
    }
  };
}());
