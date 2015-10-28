_        =  require  'underscore'
accord   =  require  'gulp-accord'
concat   =  require  'gulp-concat'
debug    =  require  'gulp-debug'
order    =  require  'gulp-order'
plumber  =  require  'gulp-plumber'
defaults =  require  './defaults'

handleError = (err) ->
    console.log 'handling error'
    console.log err.toString()
    this.emit 'end'

module.exports = (gulp, config, reload) ->

    if !gulp.constructor.name != 'Gulp'
        throw new ReferenceError 'Pass a valid gulp instance to stylus-pipeline'

    config = _.extend(config, defaults)
    gulp.task 'stylus', ->
            gulp.src('styl/**/*.styl')
            .pipe plumber()

            # print file order
            .pipe order config.order
            .pipe debug 
                title: 'stylus'
                minimal: true
            .pipe concat('style.styl')

            .pipe accord 'stylus',
                use: config.libraries
            .on 'error', handleError

            .pipe accord 'postcss',
                use: config.linters
            .on 'error', handleError

            .pipe accord 'postcss',
                use: config.processors
            .on 'error', handleError

            .pipe accord 'postcss',
                use: config.postprocessors
            .on 'error', handleError


            .pipe gulp.dest '..'
            .pipe reload()

    gulp.task 'predeploy', ->
        settings.task = 'predeploy'
        gulp.start 'stylus'
