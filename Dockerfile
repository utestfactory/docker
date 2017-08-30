FROM centos:7
MAINTAINER The U-TEST Team

# add repo for last pandoc
RUN echo -e "[puias]\nname=Puias Computational\nbaseurl=http://springdale.math.ias.edu/data/puias/computational/7/x86_64/\ngpgcheck=0\nenabled=1" >> /etc/yum.repos.d/puias-computational.repo
    
RUN yum install pandoc
