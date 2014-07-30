gulp = require "gulp"
$ = do require "gulp-load-plugins"

del = require "del"

browserify = require "browserify"
mold = require "mold-source-map"
source = require "vinyl-source-stream"

browserSync = require "browser-sync"
reload = browserSync.reload

gulp.task "jade", ->
    gulp.src "app/view/index.jade"
        .pipe $.changed "build"
        .pipe $.jade({
            pretty: true
            locals: require "./app/view/config.coffee"
        })
        .pipe gulp.dest "build"

gulp.task "styles", ->
    gulp.src "app/styles/**/*.scss"
        .pipe $.changed "build/styles"
        .pipe $.rubySass({
            loadPath: ["app/styles"]
        })
        .pipe gulp.dest "build/styles"

libs = [
    "lodash"
]
gulp.task "vendor", ->
    browserify()
        .require libs
        .bundle debug: true
        .pipe source "vendor.js"
        .pipe gulp.dest "build/scripts"

gulp.task "browserify", ->
    browserify "./app/scripts/app.coffee"
        .external libs
        .transform "coffeeify"
        .bundle debug: true
        .pipe mold.transformSourcesRelativeTo __dirname + "/app" # Fix sourcemaps in firefox
        .pipe source "bundle.js"
        .pipe gulp.dest "build/scripts"
gulp.task "clean", (cb) ->
    del ["build"], cb

gulp.task "fonts", ->
    gulp.src "app/fonts/**/*"
        .pipe gulp.dest "build/fonts"

gulp.task "images", ->
    gulp.src "app/img/**/*"
        .pipe $.imagemin
            progressive: true
            interlaced: true
        .pipe gulp.dest "build/img"

gulp.task "build", ["jade", "styles"], ->
    # process.stdout.write "\x07"
    reload()

gulp.task "browser-sync", ->
    browserSync
        server:
            baseDir: "./build"

gulp.task "watch", ["browser-sync"], ->
    gulp.watch "app/**/*", ["build"]

gulp.task "gh-pages", ["build", "fonts", "images"], ->
    gulp.src ["build/**/*", "README.md"]
        .pipe $.ghPages
            remoteUrl: "https://github.com/poitems/poitems.github.io.git"
            branch: "master"
