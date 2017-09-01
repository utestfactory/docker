# Remove const to avoid
# warning: already initialized constant FORMAT_NAMES
Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES
# limit to one format
Gollum::Page::FORMAT_NAMES = { :textile  => "Textile" }

# Specify the path to the Wiki.
gollum_path = '/wiki'
Precious::App.set(:gollum_path, gollum_path)

# Specify the wiki options.
wiki_options = {
  :live_preview => true,
  :allow_uploads => true,
  :per_page_uploads => true,
  :allow_editing => true
}
Precious::App.set(:wiki_options, wiki_options)

