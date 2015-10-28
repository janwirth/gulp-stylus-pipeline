accord   =  require  'gulp-accord'
concat   =  require  'gulp-concat'
debug    =  require  'gulp-debug'
order    =  require  'gulp-order'
plumber  =  require  'gulp-plumber'

handleError = (err) ->
    console.log 'handling error'
    console.log err.toString()
    this.emit 'end'

module.exports = (gulp, config, reload) ->
    console.log 'setting task'
    gulp.task 'stylus', ->
            gulp.src('styl/**/*.styl')
            .pipe plumber()

            .pipe order config.stylus.order
            .pipe debug # print file order
                title: 'stylus'
                minimal: true
            .pipe concat('style.styl')

            .pipe accord 'stylus', # stylus-lang.com
                use: config.stylus.libraries
            .on 'error', handleError
            .pipe accord 'postcss', # linting
                use: config.stylus.linters
            .on 'error', handleError
            .pipe accord 'postcss', # processing
                use: config.stylus.processors
            .on 'error', handleError
            .pipe accord 'postcss', # predeploy processing
                use: config.stylus.postprocessors
            .on 'error', handleError

            .pipe gulp.dest '..'
            .pipe reload()

    gulp.task 'predeploy', ->
        settings.task = 'predeploy'
        gulp.start 'stylus'
