lintRules =
    extends:
        [
            'stylelint-config-suitcss'
            'stylelint-config-wordpress'
        ]
    rules:
        'declaration-no-important': 1
        'selector-no-universal': 1
        'comment-empty-line-before': 0
        'rule-non-nested-empty-line-before': 0
        'rule-properties-order': 0
        'string-quotes': 0
        'at-rule-empty-line-before': 0
        'function-calc-no-unspaced-operator': 0


module.exports =
    libraries: # libraries used by stylus
        [
            require('axis')(), # general library
            require('rupture')() # media queries
        ]
    linters: # feedback systems for code
        [
            require('stylelint')(lintRules),
            require('postcss-bem-linter')(),
            require('postcss-reporter')()
        ]
    processors: # plugins for processing the styles
        [
            require('lost')(), #grid system
            require('postcss-responsive-type')()
        ]
    postprocessors: # predeploy processors
        [
            require('autoprefixer')() #browser prefixes
        ]
