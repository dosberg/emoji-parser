# emoji-parser for node.js

## Usage

    emoji = require('emoji-parser');
    
    emoji.init(/* You may pass a directory-name to save the images there */); /* needs to get called once */
    
    emoji.update(/* keep saved files (default: true) , callback */); /* will update your images, preferred: call while server-startup */
    
    emoji.parse('This is a :telephone:', 'http://example.com/emoji/images', {
      classes: "emoji someclass", /* default: "emoji" */
      attributes: {
        title: function(name) { return name; }, /* as default */
        alt: function(name) { return ':' + name + ':'; } /* as default */
        /* Any attributes that should get added to HTML */
      }
    });
    /* This is a <img class='emoji someclass' src='http://example.com/emoji/images/telephone.png' title='telephone' alt=':telephone:' /> */

If you pass a function instead of an object this function gets called for every replacement with the name of the emoji
to parse. The return-value will get inserted.

## Installation

`npm install emoji-parse`