/*
 * grunt-browser-extension
 * https://github.com/addmitriev/grunt-browser-extension
 *
 * Copyright (c) 2015 Aleksey Dmitriev
 * Licensed under the MIT license.
 */
'use strict';


module.exports = function(grunt) {
    // measures the time each task takes
    require('time-grunt')(grunt);
    // Project configuration.
    grunt.initConfig({
        eslint: {
            options: {
                configFile: '.eslintrc.json',
                ignores: '.eslintignore'
            },
            all: [
                'Gruntfile.js',
                'package.json',
                'tasks/**/*.js',
                '<%= nodeunit.tests %>'
            ]
        },
        // Before generating any new files, remove any previously-created files.
        clean: {
            tests: [
                'tmp',
                'build'
            ]
        },
        // Configuration to be run (and then tested).
        browser_extension: {
            default: {
                options: {
                    directory: 'test/fixtures/application',
                    id: 'com.browser.extension',
                    name: 'Browser extension test',
                    version: '0.0.0',
                    host: '*',
                    description: 'browser extension test',
                    author: 'Aleksey Dmitriev',
                    license: 'MIT',
                    icon: 'test/fixtures/application/icon.png',
                    icon_ie: 'test/fixtures/application/icon.ico',
                    icon_uninstall_ie: 'test/fixtures/application/icon.ico',
                    shortcutBool_ie: true,
                    homepage_url: 'http://home.test.com',
                    Unistall_URL: 'http://unistall.test.com',
                    content_scripts: {
                        js: [
                            'app.min.js'
                        ],
                        css: [
                            'styles.css'
                        ]
                    }
                }
            }
        },
        // Unit tests.
        nodeunit: {
            tests: [
                'test/*_test.js'
            ]
        }
    });
    // Actually load this plugin's task(s).
    grunt.loadTasks('tasks');
    // These plugins provide necessary tasks.
    grunt.loadNpmTasks('grunt-eslint');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-nodeunit');

    // Whenever the "test" task is run, first clean the "tmp" dir, then run this
    // plugin's task(s), then test the result.
    grunt.registerTask('test', ['clean', 'browser_extension', 'nodeunit']);

    // By default, lint and run all tests.
    grunt.registerTask('default', ['eslint', 'test']);
};
