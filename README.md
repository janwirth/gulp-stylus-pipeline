# stylus-pipeline
Gulp task for easily creating a complex stylus pipeline with gulp.

## Getting Started
Installation

`npm i gulp-stylus-pipeline`

Usage inside `gulpfile.js`

`require('gulp-stylus-pipeline')(gulp)`

or

`require('gulp-stylus-pipeline')(gulp, config)`

Provides a task that you can `gulp.start 'stylus'`

When no config object is passed, `exampleConfig.coffee` will be used.
The `config` object extends the `defaults` object.
Both can be found within the `lib` directory.
