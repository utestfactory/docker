# Pandoc on docker

_pandoc_ and tools dockerfile for documentation convertion (html/pdf...) on CentOS.

## Usage

  docker run -t -i --rm -v "<your git pages repository>:/wiki" utestfactory/doc
then
  pandoc <options>
(or build script)
