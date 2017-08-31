FROM ruby:alpine

MAINTAINER The U-TEST Team
# base on Dockerfile shifudao/gollum with 'textile' support

RUN apk update && \
    apk add make gcc g++ icu-libs icu-dev git && \
    gem install gollum org-ruby RedCloth && \
    apk del make gcc g++ icu-dev && \
    rm -fr /var/cache/apk/* /usr/local/bundle/cache /root/.gem/ /root/.gemrc /root/.ash_history && \
    find /usr/local/bundle/ \( -name 'gem_make.out' -o -name 'mkmf.log' \) -delete

COPY config.rb /usr/local/etc/

VOLUME /wiki
WORKDIR /wiki
EXPOSE 4567

CMD ["gollum", "--allow-uploads page", "--config /usr/local/etc/config.rb" ]
