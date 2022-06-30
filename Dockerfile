FROM rightscale/ops_ruby21x_build

WORKDIR /srv

# Setup Surge (Node.js + surge)
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN npm install --global surge

# Setup Ruby bundle
COPY Gemfile* /srv/
RUN bundle install

# Copy required files
COPY Rakefile config.* /srv/
COPY util /srv/util/
COPY source /srv/source/
COPY data /srv/data/

# Pull down latest policies.json to docker image
RUN curl -s -o /srv/data/policies.json https://s3.amazonaws.com/rs-policysync-tool/active-policy-list.json

EXPOSE 4567 23729

CMD ["bundle", "exec", "rake", "serve"]
