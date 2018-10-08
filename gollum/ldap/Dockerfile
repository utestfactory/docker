FROM utestfactory/gollum

MAINTAINER The U-TEST Team
# base on Dockerfile shifudao/gollum with 'textile' support

RUN gem install omniauth omniauth-ldap omnigollum

# Add ldap settings in current config.rb
COPY config.add.ldap /usr/local/etc/
RUN cat /usr/local/etc/config.add.ldap >> /usr/local/etc/config.rb
