# emoji-parser for node.js

## About

This script makes it easy to keep the emoji-images in sync with the [official repository](https://github.com/arvida/emoji-cheat-sheet.com) of [emoji-cheat-sheet.com](http://www.emoji-cheat-sheet.com/).
It's just an additional call on server-startup (or whenever you want to synchronize).

The actual parsing works without any DOM-manipulation or whatever, just a simple replace call.

## Why another one?

This project is inspired by [emoji-images](https://github.com/HenrikJoreteg/emoji-images), but this project hasn't been modified for some time now and the author isn't responding to issues.

Because of this and a few more customizations I rewrote this in coffee-script which is much more fun to code :smile:.

So this has become way more customizable (up to passing own parser-function) and the emoji-synchronization happens server-side instead of project-side.

## Usage

    var emoji = require('emoji-parser');
    
    // next two calls will keep your emoji (within the given directory) in sync with the official repository
    emoji.init(/* You may pass a directory-name to save the images there */); /* needs to get called before update */
    emoji.update(/* keep saved files (default: true) , callback */); /* will update your images, preferred: call while server-startup */
    
    // The actual parsing may be run at any time:
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

With `emoji.emoji` you can retrieve the current list of emoji that are ensured to be on your file-system.
`emoji.list()` instead returns the list of emoji that gets used within the parse-function.
The difference between those two is that `emoji.list()` even returns an array when `init` didn't get called therefor the
`init` and `update` methods are optional.

## Installation

`npm install emoji-parser`
