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
        :title => '$ldaptitle',
        :host => '$ldapsrv',
        :port => 3268,
        :method => :plain,
        :base => '$base',
        :uid => 'sAMAccountName',
        #:filter => '(&(uid=%{username})(memberOf=cn=myapp-users,ou=groups,dc=example,dc=com))',
        #:name_proc => Proc.new {|name| name.gsub(/@.*$/,'')},
        :bind_dn => '$aduser',
        :password => '$password'
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
