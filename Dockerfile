FROM ruby:2.7.2

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                      libpq-dev
#yarnのインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

#Nodejsをバージョン指定してインストール
# RUN curl -sL https://deb.nodesource.com/setup_14.15.1 | bash - && \
RUN apt-get install -y nodejs npm && npm install n -g && n 14.15.1 && yarn add vue@next vue-loader@next @vue/compiler-sfc
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV APP_ROOT /app 

RUN mkdir /$APP_ROOT
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# RUN gem install bundler -v 1.3.0 (途中から追加する場合はbundlerの指定も必要)
RUN bundle install
ADD . $APP_ROOT
