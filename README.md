Jekyll Authors
==============

This gem provides a [Jekyll](http://github.com/mojombo/jekyll) generator for
author pages, author feeds and an author index.

Basic Setup
-----------
Install the gem:

	[sudo] gem install jekyll-authors

In a plugin file within your Jekyll project's _plugins directory:

	# _plugins/my-plugin.rb
	require "jekyll-authors"

Create the following layouts:

- author_index.html
- author_list.html
- author_feed.xml

Bundler Setup
-------------
Already using bundler to manage gems for your Jekyll project?  Then just add

	gem "jekyll-authors"

to your gemfile and create the following plugin in your projects _plugins
directory.  I've called mine bundler.rb.  This will automatically require all
of the gems specified in your Gemfile.

	# _plugins/bundler.rb
	require "rubygems"
	require "bundler/setup"
	Bundler.require(:default)
