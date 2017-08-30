FROM centos:7
MAINTAINER The U-TEST Team

# add repo for last pandoc
RUN echo -e "[puias]\nname=Puias Computational\nbaseurl=http://springdale.math.ias.edu/data/puias/computational/7/x86_64/\ngpgcheck=0\nenabled=1" >> /etc/yum.repos.d/puias-computational.repo
# and install it
RUN yum install -y pandoc

# add filters for python
RUN wget https://github.com/jgm/pandocfilters/archive/1.4.2.tar.gz && \
    tar xzf 1.4.2.tar.gz && \
    cd pandocfilters-1.4.2 && \
    python setup.py install && \
    cd .. && \
    rm pandocfilters

