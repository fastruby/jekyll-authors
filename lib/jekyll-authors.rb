require 'jekyll-authors/tags'

module Jekyll
  module Authors
    class AuthorIndex < Page
      def initialize(site, base, dir, author)
        @site = site
        @base = base
        @dir = dir
        @name = 'index.html'

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'author_index.html')
        self.data['author'] = author

        author_title_prefix = site.config['author_title_prefix'] || 'Author: '
        self.data['title'] = "#{author_title_prefix}#{author}"
      end
    end

    class AuthorFeed < Page
      def initialize(site, base, dir, author)
        @site = site
        @base = base
        @dir = dir
        @name = 'atom.xml'

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'author_feed.xml')
        self.data['author'] = author

        author_title_prefix = site.config['author_title_prefix'] || 'Author: '
        self.data['title'] = "#{author_title_prefix}#{author}"
      end
    end

    class AuthorList < Page
      def initialize(site,  base, dir, authors)
        @site = site
        @base = base
        @dir = dir
        @name = 'index.html'

        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'author_list.html')
        self.data['authors'] = authors
      end
    end

    class AuthorGenerator < Generator
      safe true

      def generate(site)
        if site.layouts.key? 'author_index'
          dir = site.config['author_dir'] || 'authors'
          site.authors.keys.each do |author|
            write_author_index(site, File.join(dir, author.gsub(/\s/, "-").gsub(/[^\w-]/, '').downcase), author)
          end
        end

        if site.layouts.key? 'author_feed'
          dir = site.config['author_dir'] || 'authors'
          site.authors.keys.each do |author|
            write_author_feed(site, File.join(dir, author.gsub(/\s/, "-").gsub(/[^\w-]/, '').downcase), author)
          end
        end

        if site.layouts.key? 'author_list'
          dir = site.config['author_dir'] || 'authors'
          write_author_list(site, dir, site.authors.keys.sort)
        end
      end

      def write_author_index(site, dir, author)
        index = CategoryIndex.new(site, site.source, dir, author)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.static_files << index
      end

      def write_author_feed(site, dir, author)
        index = AuthorFeed.new(site, site.source, dir, author)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.static_files << index
      end

      def write_author_list(site, dir, authors)
        index = AuthorList.new(site, site.source, dir, authors)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.static_files << index
      end
    end

    # Returns a correctly formatted author url based on site configuration.
    #
    # Use without arguments to return the url of the author list page.
    #    {% author_url %}
    #
    # Use with argument to return the url of a specific catogory page.  The
    # argument can be either a string or a variable in the current context.
    #    {% author_url author_name %}
    #    {% author_url author_var %}
    #
    class AuthorUrlTag < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @author = text
      end

      def render(context)
        base_url = context.registers[:site].config['base-url'] || '/'
        author_dir = context.registers[:site].config['author_dir'] || 'authors'

        author = context[@author] || @author.strip.tr(' ', '-').downcase
        author.empty? ? "#{base_url}#{author_dir}" : "#{base_url}#{author_dir}/#{author}"
      end
    end
  end
end

Liquid::Template.register_tag('author_url', Jekyll::Authors::AuthorUrlTag)
