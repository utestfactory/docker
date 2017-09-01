# Pandoc on docker

_pandoc_ and tools dockerfile for documentation convertion (html/pdf...) on CentOS.

## USage

docker run -t -i --rm -v "<your wiki pages directory>:/wiki" utestfactory/docker
then
pandoc <options>
(or build script)
