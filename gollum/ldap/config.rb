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


## Omni Auth
require 'omnigollum'

# github auth
require 'omniauth-ldap'

options = {
  :providers => Proc.new do
    provider :ldap,
        :title => ENV['LDAP_TITLE'],
        :host => ENV['LDAP_HOST'],
        :port => ENV['LDAP_PORT'],
        :method => :plain,
        :base => ENV['LDAP_BASE'],
        :uid => ENV['LDAP_UID'],
        #:filter => '(&(uid=%{username})(memberOf=cn=myapp-users,ou=groups,dc=example,dc=com))',
        #:name_proc => Proc.new {|name| name.gsub(/@.*$/,'')},
        :bind_dn => ENV['LDAP_BIND_DN'],
        :password => ENV['LDAP_PASS']
  end,
  :dummy_auth => false,
  :protected_routes => ['/*'],
  :author_format => Proc.new { |user| user.name },
  :author_email => Proc.new { |user| user.email },

  :authorized_users => nil,
}

## :omnigollum options *must* be set before the Omnigollum extension is registered
Precious::App.set(:omnigollum, options)
Precious::App.register Omnigollum::Sinatra
