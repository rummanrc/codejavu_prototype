FROM ruby:2.7.0
RUN apt-get update -qq \
&& apt-get install -y nodejs postgresql-client
ADD . /codejavu-docker
WORKDIR /codejavu-docker
RUN bundle install
RUN rake languages:seed_languages
RUN rake tags:seed_tags
EXPOSE 3000
CMD ["bash"]