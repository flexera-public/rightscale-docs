###
# Handbook Config
###

Time.zone = "US/Pacific"

class RightScaleCustomMarkdown < Redcarpet::Render::HTML
  def initialize(options={})
    super options.merge(
      :with_toc_data                => true,
    )
  end

  # Pre process all the RS-specific markdown tags
  def preprocess(document)

    # We need this renderer to force render of content within our multi-line markdown elements
    # Note this is the same config used later in this file for the generic middleman renderer
    r = Redcarpet::Markdown.new(self, options = {
      :markdown => true,
      :fenced_code_blocks           => true,
      :no_intra_emphasis            => true,
      :tables                       => true,
      :disable_indented_code_blocks => true,
      :quote                        => true,
      :lax_spacing                  => true
    })

    # Render all of our custom markdown elements
    rendered_doc = custom_alerts(document, r)
    rendered_doc = custom_code_tabs(rendered_doc, r)
    rendered_doc = custom_content_card(rendered_doc, r)
    rendered_doc = custom_header_anchors(rendered_doc, r)
  end

  # Since we use h2 and h3 for our right-nav, we need to do something
  # special with H3s to allow for multiple H3s with the same text (i.e
  # ResourceA - Usage, Examples -- ResourceB, Usage, Examples). The built-in
  # TOC plugin just uses the h3 text, but that won't work with multiple H3s
  # with the same text, so we'll overwrite H3s only to include the name of the
  # previous h2 as a prefix. We don't touch the rest of the headers - leave
  # that to redcarpet
  # We'll also handle h2 anchor names so that we can have weird chars in our
  # H2s, like ? or ()
  def custom_header_anchors(document, renderer)
    # This is what we'll return
    newdoc = ""

    # Placeholder for parent name
    parent = ""

    # Go through line by line so we can save the parent as we go
    document.lines.each do |l|

      # If this is a H2, save the parent and encode the anchor
      if m = l.match(/^## (.*)\n/)
        parent = encode_anchor(m[1])
        l = "<h2 id=\"#{parent}\">#{m[1]}</h2>\n"
      end

      # If it's an H3, create the anchor text and render the HTML
      if m = l.match(/^### (.*)\n/)
        anchor_val = parent + "-" + encode_anchor(m[1])
        l = "<h3 id=\"#{anchor_val}\">#{m[1]}</h3>\n"
      end

      # Add this line (modified or not) to the newdoc
      newdoc << l
    end

    newdoc
  end

  def encode_anchor(name)
    name.downcase.gsub(/[\s\(\)\?\.'\/:\&\`\"]/, "-")
  end

  # Custom renderer for the "alert" style type in the styleguide
  def custom_alerts(document, renderer)
    document.gsub(/^!!(.*)\*(.*)\*(.*)/) do
      "<div class=\"alert alert-#{$1}\" role=\"alert\"><strong>#{$2}</strong>#{renderer.render($3)}</div>"
    end
  end

  # Custom renderer for the "content card" style type in the styleguide
  def custom_content_card(document, renderer)
    document.gsub(/^\[\[(.*?)\n(.*?)\n([^\n]*?)\]\]/m) do
      resp = "<div class=\"panel panel-default\">
        <div class=\"panel-heading\">
          <div class=\"panel-title\">
          #{$1}
          </div>
        </div>
        <div class=\"panel-body\">"
      resp = resp + renderer.render($2)
      resp = resp + "</div>
        <div class=\"panel-footer\">#{$3}</div>
      </div>"
      resp
    end
  end

  # Custom renderer for the tabulated code displays
  def custom_code_tabs(document, renderer)
    panel_header = '<div class="tabpanel"><ul class="nav nav-tabs">'
    panel_footer = '</ul></div>'
    content_header = "<div class=\"clearfix\">\n<div class=\"tab-content tab-doc\">"
    content_footer = "</div>\n</div>"

    document.gsub(/^\[\[\[\n(.*?)^\]\]\]/m).each_with_index do |ts, j|
      panel_source = $1

      panel = panel_header
      content = content_header

      panel_source.gsub(/^\#\#\#(.*?)\n(.*?)(!?^###\n)/m).each_with_index do |t,i|
        tab_name = $1.strip
        tab_id = "tab-" + j.to_s + "-" + i.to_s

        panel = panel + '<li'
        panel = panel + ' class="active"' if i == 0
        panel = panel + '><a href="#' + tab_id + '" data-toggle="tab">' + tab_name + '</a></li>'
        content = content + '<div class="tab-pane fade in'
        content = content + ' active' if i == 0
        content = content + '" id="' + tab_id + '">'
        content = content + renderer.render($2)
        content = content + '</div>'
      end

      content = content + content_footer
      panel = panel + panel_footer

      panel + content
    end

  end

  # Force our custom renderer class to use the middleman code renderer
  def block_code(code, language)
    Middleman::Syntax::Highlighter.highlight(code, language)
  end

  def image(link, title, alt_text)
    if link[0] == '/'
      highres_path = './source' + link.gsub(/\.(jpg|png|gif)$/, '@*x.\1')
      srcset = Dir[highres_path].map do |f|
        resolution = f.match(/@(\dx)\./)[1]
        path = f.split('/source')[1]
        "#{path} #{resolution}"
      end.join(', ')
      size = FastImage.size('./source' + link)
    else
      srcset = ''
      size = FastImage.size(link)
    end

    output = "<img src=\"#{link}\" alt=\"#{alt_text}\""
    output << " srcset=\"#{srcset}\"" if srcset.length > 0
    output << " title=\"#{title}\"" unless title.nil?
    output << " width=\"#{size[0]}\" height=\"#{size[1]}\"" unless size.nil?
    output + " />"
  end
end

activate :syntax, :css_class => 'syntax-highlight', :line_numbers => false

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

# Slim configuration
Slim::Engine.set_options pretty: true, sort_attrs: false

# Page layouts
page "/ss/*", :layout => :ss_layout
page "/rl10/*", :layout => :rl10_layout
page "/rl6/*", :layout => :rl6_layout
page "/cm/*", :layout => :cm_layout
page "/st/*", :layout => :st_layout
page "/api/*", :layout => :api_layout
page "/faq/*", :layout => :faq_layout
page "/rcav/*", :layout => :rcav_layout
page "/ca/*", :layout => :ca_layout
page "/gov/*", :layout => :gov_layout
page "/platform/*", :layout => :platform_layout
page "/servicenow/*", :layout => :servicenow_layout
page "/optima/*", :layout => :optima_layout
page "/policies/*", :layout => :policies_layout

# Slim markdown redcarpet
Slim::Embedded.set_options(
  :markdown => {
    :fenced_code_blocks           => true,
    :no_intra_emphasis            => true,
    :tables                       => true,
    :with_toc_data                => true,
    :disable_indented_code_blocks => true,
    :quote                        => true
  }
)

# Markdown configuration
set :markdown_engine, :redcarpet
set(
  :markdown,
  :fenced_code_blocks           => true,
  :no_intra_emphasis            => true,
  :tables                       => true,
  :disable_indented_code_blocks => true,
  :quote                        => true,
  :lax_spacing                  => true,
  :renderer                     => RightScaleCustomMarkdown
)

# Release notes
activate :blog do |blog|
  blog.name = "release-notes"
  blog.layout = "release_notes_single"
  blog.prefix = "release-notes"
  blog.sources = "{category}/{year}-{month}-{day}-{title}.html"
  blog.permalink = "{category}/{year}/{month}/{day}.html"
  blog.summary_length = 500
  blog.paginate = true
  blog.page_link = "page{num}"
  blog.per_page = 5
  blog.custom_collections = {
    category: {
      link: '/{category}.html',
      template: '/release-notes/category.html'
    },
    week: {
      link: '/week-of-{week}.html',
      template: '/release-notes/weekly.html'
    }
  }
end

# development configuration
configure :development do
  activate :livereload, host: '127.0.0.1'
end

activate :trailing_slashes

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  compass_config do |config|
    config.output_style = :expanded
    config.line_comments = false
  end

  # Minify on build
  Slim::Engine.set_options pretty: false, sort_attrs: true
  activate :minify_css
  activate :minify_javascript

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

# middleman-deploy configuration
case ENV['TARGET'].to_s.downcase
when 'test'
  activate :deploy do |deploy|
    # Automatically run `middleman build` during `middleman deploy`
    deploy.build_before = true

    # rsync, ftp, sftp, or git
    deploy.method = :git
    deploy.branch = "test-gh-pages"
  end
else
  activate :deploy do |deploy|
    # Automatically run `middleman build` during `middleman deploy`
    deploy.build_before = true

    # rsync, ftp, sftp, or git
    deploy.method = :git
  end
end


page "/release-feed.xml", :layout => false

# Activate middleman-breadcrumb gem
activate :breadcrumbs
set :separator, " / "

# Add redirects for all pages listed in /data/redirects.yml
data.redirects.each do |redirect|
  redirect "#{redirect.original}", to: redirect.redirect
end

# This must be the last thing activated. It's important that other modules have the
# opportunity to do their own URL manipulations before the alias redirect pages are generated.
activate :alias
