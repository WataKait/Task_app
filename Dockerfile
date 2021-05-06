FROM ruby:2.6.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
        vim zsh less \
        locales \
    && locale-gen ja_JP.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

RUN chsh -s /usr/bin/zsh

ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN touch ~/.vimrc
RUN echo "set encoding=utf-8" >> ~/.vimrc
RUN echo "set fileencodings=utf-8,cp932,euc-jp,sjis" >> ~/.vimrc
RUN echo "set fileformats=unix" >> ~/.vimrc
