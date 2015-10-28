gulp.task 'stylus', ->
    gulp.src('styl/**/*.styl')
        .pipe plumber()

        .pipe order settings.stylus.order
        .pipe debug # print file order
            title: 'stylus'
            minimal: true
        .pipe concat('style.styl')

        .pipe accord 'stylus', # stylus-lang.com
            use: settings.stylus.libraries
        .on 'error', handleError
        .pipe accord 'postcss', # linting
            use: settings.stylus.linters
            configBasedir: '/var/www/html/wordpress/wp-content/themes/wp-visual4-corechild/dev/'
        .on 'error', handleError
        .pipe accord 'postcss', # processing
            use: settings.stylus.processors
        .on 'error', handleError
        .pipe accord 'postcss', # predeploy processing
            use: settings.stylus.postprocessors
        .on 'error', handleError

        .pipe gulp.dest '..'
        .pipe reload()
