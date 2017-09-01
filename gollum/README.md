# Gollum on docker

_gollum_ dockerfile for documentation authoring

Based on _ruby/alpine_ (for lightweight _docker_ image).

## Usage

You could add _gollum_ arguments to run this docker.

For example: docker run ... utestfactory/gollum --ref=branch

### As a daemon

docker run -d -p 4567:4567 -v "<your wiki pages directory>:/wiki" --name gollum utestfactory/gollum

### For test

docker run --rm -p 4567:4567 -v "<your wiki pages directory>:/wiki" utestfactory/gollum

### For test with console

docker run -t -i --rm -p 4567:4567 -v "<your wiki pages directory>:/wiki" --entrypoint="ash" utestfactory/gollum
then
gollum --config /usr/local/etc/config.rb

## Credential version

Version with credential. To be used locally.
Check _gollum/ldap_ directory for _ldap_ version.
