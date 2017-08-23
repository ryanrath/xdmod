var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var sourcemaps = require('gulp-sourcemaps');
var rename = require('gulp-rename');
var cleanCSS = require('gulp-clean-css');
var del = require('del');
var vinyl = require('vinyl-paths');
var path = require('path');
var argv = require('yargs')
      .demand(['type'])
      .default('type', 'directory')
      .argv;
var gutil = require('gulp-util');

var type = argv.type;
var assetDir = path.resolve(__dirname, 'configuration');

var validTypes = [
  'directory',
  'file'
];

if (validTypes.indexOf(type) < 0) {
  gutil.log(gutil.colors.red('error'), "Unknown 'type' must be one of: " + validTypes.join(', '));
  process.exit(-1);
}

// Retrieve the current set of assets to operate on given the provided
// operation type.
var assets = new require(path.resolve(assetDir, './assets.js'))(type).getAssets();

// Build Sub-Tasks =============================================================
gulp.task('internal-dashboard-logged-in-libs', function() {
  return gulp
    .src(assets.internal_dashboard.loggedIn.libs)
    .pipe(sourcemaps.init())
    .pipe(concat('internal-dashboard-loggedIn-libs.js'))
    .pipe(gulp.dest('./dist/'))
    .pipe(rename('internal-dashboard-loggedIn-libs.min.js'))
    .pipe(uglify({mangle: false}))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('default', ['internal-dashboard-logged-in-libs']);

// Clean
/*gulp.task('clean-splash-libs', function() {
    return gulp
    .src([
        './dist/splash-libs.js',
        './dist/splash-libs.min.js',
        './dist/splash-libs.min.js.map',
        './html/gui/js/splash-libs.js',
        './html/gui/js/splash-libs.min.js',
        './html/gui/js/splash-libs.min.js.map'
    ])
    .pipe(vinyl(del));
});*/
/*gulp.task('splash-libs', ['clean-splash-libs'], function() {
  return gulp
    .src(assets.splash.libs)
    .pipe(sourcemaps.init())
    .pipe(concat('splash-libs.js'))
    .pipe(gulp.dest('./dist/'))
    .pipe(rename('splash-libs.min.js'))
    .pipe(uglify({mangle: false}))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('libs', ['clean-libs'], function() {
  return gulp
    .src(assets.loggedIn.libs)
    .pipe(sourcemaps.init())
    .pipe(concat('libs.js'))
    .pipe(gulp.dest('./dist/'))
    .pipe(rename('libs.min.js'))
    .pipe(uglify({mangle: false}))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('splash-scripts', ['clean-splash-scripts'], function() {
  return gulp
    .src(assets.splash.scripts)
    .pipe(sourcemaps.init())
    .pipe(concat('splash-bundle.js'))
    .pipe(gulp.dest('./dist/'))
    .pipe(rename('splash-bundle.min.js'))
    .pipe(uglify({mangle: false}))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('scripts', ['clean-scripts'], function() {
  return gulp
    .src(assets.loggedIn.scripts)
    .pipe(sourcemaps.init())
    .pipe(concat('bundle.js'))
    .pipe(gulp.dest('./dist/'))
    .pipe(rename('bundle.min.js'))
    .pipe(uglify({mangle: false}))
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('splash-css', ['clean-splash-css'], function() {
  return gulp
    .src(assets.splash.css)
    .pipe(sourcemaps.init())
    .pipe(concat('splash-bundle.css'))
    .pipe(gulp.dest('./dist/.'))
    .pipe(rename('splash-bundle.min.css'))
    .pipe(cleanCSS())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

gulp.task('css', ['clean-css'], function() {
  return gulp
    .src(assets.loggedIn.css)
    .pipe(sourcemaps.init())
    .pipe(concat('bundle.css'))
    .pipe(gulp.dest('./dist/.'))
    .pipe(rename('bundle.min.css'))
    .pipe(cleanCSS())
    .pipe(sourcemaps.write('./'))
    .pipe(gulp.dest('./dist/'));
});

// Clean Sub-Tasks =============================================================
gulp.task('clean-splash-libs', function() {
  return gulp
    .src([
      './dist/splash-libs.js',
      './dist/splash-libs.min.js',
      './dist/splash-libs.min.js.map',
      './html/gui/js/splash-libs.js',
      './html/gui/js/splash-libs.min.js',
      './html/gui/js/splash-libs.min.js.map'
    ])
    .pipe(vinyl(del));
});

gulp.task('clean-splash-scripts', function() {
  return gulp
    .src([
      './dist/bundle.js',
      './dist/bundle.min.js',
      './dist/bundle.min.js.map',
      './html/gui/js/bundle.js',
      './html/gui/js/bundle.min.js',
      './html/gui/js/bundle.min.js.map'
    ])
    .pipe(vinyl(del));
});

gulp.task('clean-libs', function() {
  return gulp
    .src([
      './dist/libs.js',
      './dist/libs.min.js',
      './dist/libs.min.js.map',
      './html/gui/js/libs.js',
      './html/gui/js/libs.min.js',
      './html/gui/js/libs.min.js.map'
    ])
    .pipe(vinyl(del));
});

gulp.task('clean-scripts', function() {
  gulp
    .src([
      './dist/bundle.js',
      './dist/bundle.min.js',
      './dist/bundle.min.js.map',
      './html/gui/js/bundle.js',
      './html/gui/js/bundle.min.js',
      './html/gui/js/bundle.min.js.map'
    ])
    .pipe(vinyl(del));
});

gulp.task('clean-splash-css', function(){
  return gulp
    .src([
      './dist/splash-bundle.css',
      './dist/splash-bundle.min.css',
      './dist/splash-bundle.min.css.map',
      './html/gui/css/splash-bundle.css',
      './html/gui/css/splash-bundle.min.css',
      './html/gui/css/splash-bundle.min.css.map'
    ])
    .pipe(vinyl(del));
});

gulp.task('clean-css', function() {
  return gulp
    .src([
      './dist/bundle.css',
      './dist/bundle.min.css',
      './dist/bundle.min.css.map',
      './html/gui/css/bundle.css',
      './html/gui/css/bundle.min.css',
      './html/gui/css/bundle.min.css.map'
    ])
    .pipe(vinyl(del));
});

// Distribution Tasks ==========================================================

gulp.task('dist-splash-libs', ['splash-libs'], function() {
  return gulp
    .src([
      './dist/splash-libs.js',
      './dist/splash-libs.min.js',
      './dist/splash-libs.min.js.map'
    ])
    .pipe(gulp.dest('./html/gui/js'));
});

gulp.task('dist-libs', ['libs'], function() {
  return gulp
    .src([
      './dist/libs.js',
      './dist/libs.min.js',
      './dist/libs.min.js.map'
    ])
    .pipe(gulp.dest('./html/gui/js'));
});

gulp.task('dist-splash-scripts', ['splash-scripts'], function() {
  return gulp
    .src([
      './dist/splash-bundle.js',
      './dist/splash-bundle.min.js',
      './dist/splash-bundle.min.js.map'
    ])
    .pipe(gulp.dest('./html/gui/js'));
});

gulp.task('dist-scripts', ['scripts'], function() {
  return gulp
    .src([

      './dist/bundle.js',
      './dist/bundle.min.js',
      './dist/bundle.min.js.map'
    ])
    .pipe(gulp.dest('./html/gui/js/'));
});

gulp.task('dist-splash-css', ['splash-css'], function() {
  return gulp
    .src([
      './dist/splash-bundle.css',
      './dist/splash-bundle.min.css',
      './dist/splash-bundle.min.css.map'
    ])
    .pipe(gulp.dest('./html/gui/css'));
});


gulp.task('dist-css', ['css'], function() {
  return gulp
    .src([
      './dist/bundle.css',
      './dist/bundle.min.css',
      './dist/bundle.min.css.map'
    ])
    .pipe(gulp.dest('./html/gui/css/'));
});

// Watch Tasks =================================================================
gulp.task('watch-splash-css', function() {
  gulp.watch(assets.splash.css, ['dist-splash-css']);
});
gulp.task('watch-css', function() {
  gulp.watch(assets.loggedIn.css, ['dist-css']);
});
gulp.task('watch-splash-scripts', function() {
  gulp.watch(assets.splash.scripts, ['dist-splash-scripts']);
});
gulp.task('watch-scripts', function() {
  gulp.watch(assets.loggedIn.scripts, ['dist-scripts']);
});
gulp.task('watch-splash-libs', function() {
  gulp.watch(assets.splash.libs, ['dist-splash-libs']);
});
gulp.task('watch-libs', function() {
  gulp.watch(assets.loggedIn.libs, ['dist-libs']);
});

// Main Tasks ==================================================================
/!**
 * Cleans / Builds / Distributes all css and js
 **!/
gulp.task('default', ['dist-splash-scripts', 'dist-scripts', 'dist-splash-libs', 'dist-libs', 'dist-splash-css', 'dist-css']);

/!**
 * Watches all of the css / scripts / libs and on change fires off the respective
 * clean / build step so that the change is incorporated into the the bundled
 * files.
 **!/
gulp.task('watch', ['watch-splash-scripts', 'watch-scripts', 'watch-splash-css', 'watch-css', 'watch-splash-libs', 'watch-libs']);

/!**
 * A shortcut parent-task for all of the clean sub-tasks.
 **!/
gulp.task('clean-all', ['clean-css', 'clean-libs', 'clean-scripts', 'clean-splash-css', 'clean-splash-libs', 'clean-splash-scripts']);*/
