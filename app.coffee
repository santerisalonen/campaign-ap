# set up contentful config as environment variables (in dev)
try 
  env = require './env' 
  process.env.access_token = env.access_token
  process.env.space_id = env.space_id
catch err
        
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'
slugify      = require 'slug'

slugify.defaults.modes['pretty']['lower'] = true 

config = 
  gtmContainer: 'XXXXXXX'
  branch: process.env.BRANCH


module.exports =
  
  locals:
    config: config
  
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'env.coffee']
  
  extensions: [
    contentful(
      access_token: process.env.access_token
      space_id: process.env.space_id
      content_types:
        pages:
          id: 'page'
          template: 'views/_page.hbs'
          path: (e) -> "#{slugify(e.name)}"     
    )
    js_pipeline(
        files: [ "assets/js/jquery-3.2.1.js", "assets/js/jquery.validate.min.js", "assets/js/marked.js", "assets/js/function.js" ], 
        out: 'js/build.js', 
        minify: true
    )
    css_pipeline(
        files: [ "assets/css/bootstrap.css", "assets/css/master.css"], 
        out: 'css/build.css', 
        minify: false
    )
  ]

