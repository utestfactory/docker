# add own filter for requirement rendering
require '/usr/local/etc/pvt'
require '/usr/local/etc/amalgamation'

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
  :allow_editing => true,
  :css => true,
# filter_chain is taken from wiki.rb. Remember to update when new gollum version !!
  :filter_chain => [:Amalgamation, :Pvt, :Metadata, :PlainText, :TOC, :RemoteCode, :Code, :Emoji, :Sanitize, :WSD, :PlantUML, :Tags, :Render]
}
Precious::App.set(:wiki_options, wiki_options)
