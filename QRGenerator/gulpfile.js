var gulp = require('gulp');
var eslint = require('gulp-eslint');

gulp.task('watch-app', function () {
  gulp.watch([
    './index.ios.js',
    './app/**/*.*'
  ], ['lint']);
});

gulp.task('lint', () => {
  return gulp.src([
    './index.ios.js',
    './app/**/*.*'
  ])
  .pipe(eslint())
  .pipe(eslint.format())
  .pipe(eslint.failAfterError());
});

