var gulp = require('gulp');
var globbing = require('gulp-css-globbing');
var sourcemaps = require('gulp-sourcemaps');
var livereload = require('gulp-livereload');
var sass = require('gulp-sass');

gulp.task('sass', function() {
    return gulp.src(['assets/scss/app.scss'])
        .pipe(globbing({
            extensions: ['.scss']
        }))
        .pipe(sourcemaps.init())
        .pipe(sass())
        .on('error', swallowError)
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('assets/css'))
        .pipe(livereload());
});

gulp.task('lr_sass', function() {

    gulp.src('./assets/scss/layouts/*.scss')
        .pipe(sass({
            // outputStyle: 'compressed'
        }))
        .pipe(gulp.dest('./assets/css'));
});

// Watch Files For Changes
gulp.task('watch', function() {
    // gulp.watch('assets/scss/**/*.scss', ['sass']);
    gulp.watch('assets/scss/*.scss', ['sass']);
    gulp.watch('assets/scss/layouts/*.scss', ['sass']);
});

function swallowError(error) {

    // If you want details of the error in the console
    console.log("VOI PERKELE\n\n" + error.toString());

    this.emit('end');
}

// Default Task
gulp.task('default', ['sass', 'watch']);
