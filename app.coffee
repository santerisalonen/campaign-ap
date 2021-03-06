# set up contentful config as environment variables (in dev)
config = 
  production: true
  host: 'https://kampanja.apollomatkat.fi';
  
try 
  env = require './env' 
  process.env.access_token = env.access_token
  process.env.space_id = env.space_id
  config.production = false;
  config.host = 'https://localhost:1111'
catch err
        
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'
slugify      = require 'slug'
marked       = require 'marked'



slugify.defaults.modes['pretty']['lower'] = true 

module.exports =
  locals:
    config: config
    marked: marked  
    slugify: slugify
  
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
          write: 'pages.json'
    )
    js_pipeline(
        files: [ "assets/js/jquery-3.2.1.js", "assets/js/jquery.validate.min.js", "assets/js/functions.js" ], 
        out: 'js/build.js', 
        minify: true
    )
    css_pipeline(
        files: [ "assets/css/bootstrap.css", "assets/css/master.css"], 
        out: 'css/build.css', 
        minify: false
    )
  ]

