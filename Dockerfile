FROM ruby:2.6.3

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add \
  && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        vim zsh less \
        locales \
        nodejs \
        google-chrome-stable \
    && locale-gen ja_JP.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn

RUN chsh -s /usr/bin/zsh

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN touch ~/.vimrc
RUN echo "set encoding=utf-8" >> ~/.vimrc
RUN echo "set fileencodings=utf-8,cp932,euc-jp,sjis" >> ~/.vimrc
RUN echo "set fileformats=unix" >> ~/.vimrc
