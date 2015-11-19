_        =  require  'underscore'
accord   =  require  'gulp-accord'
concat   =  require  'gulp-concat'
debug    =  require  'gulp-debug'
order    =  require  'gulp-order'
plumber  =  require  'gulp-plumber'
defaults =  require  './defaults'
poststylus = require 'poststylus'

handleError = (err) ->
    console.log 'handling error'
    console.log err.toString()
    this.emit 'end'

module.exports = (gulp, config) ->
    if gulp.constructor.name != 'Gulp'
        throw new ReferenceError 'Pass a valid gulp instance to stylus-pipeline'

    # prepare config
    if !config?
        config = require './exampleConfig'
    config = _.extend(defaults, config)

    allPlugins = config.libraries # only stylus libraries
    allPostCssPlugins = config.processors # only linters
    allPostCssPlugins.concat(
        config.postprocessors
    )

    allPlugins.push(poststylus config.linters)
    allPlugins.push(poststylus allPostCssPlugins)


    gulp.task 'stylus', ->
        gulp.src(config.styleFileDirectory + '/**/*.styl')

            # print file order
            .pipe order config.order
            .pipe debug 
                title: 'stylus'
                minimal: true
            .pipe concat('style.styl')

            .pipe accord 'stylus',
                use: allPlugins
            .on 'error', handleError
            .pipe gulp.dest '..'

    gulp.task 'predeploy', ->
        settings.task = 'predeploy'
        gulp.start 'stylus'
