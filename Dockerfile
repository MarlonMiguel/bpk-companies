# syntax = docker/dockerfile:1

# Use uma imagem base do Ubuntu
FROM ubuntu:22.04

# Instale as dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y \
    curl \
    gnupg2 \
    software-properties-common \
    build-essential \
    git \
    libpq-dev \
    libvips \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Instale Ruby
RUN apt-get install -y ruby-full

# Instale o Bundler
RUN gem install bundler

# Defina o diretório de trabalho
WORKDIR /rails

# Copie o Gemfile e o Gemfile.lock e instale as gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copie o código da aplicação
COPY . .

# Instale as dependências do npm
RUN npm install

# Precompile assets (se necessário)
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Exponha a porta padrão do Rails
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["./bin/dev"]
