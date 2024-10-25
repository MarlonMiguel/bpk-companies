# syntax = docker/dockerfile:1

# Use uma imagem base do Ruby
FROM ruby:3.3.1

# Instale dependências do sistema
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
    netcat-openbsd && \
    rm -rf /var/lib/apt/lists/*  # Remover listas de pacotes

# Instale o Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash && \
    ln -s /root/.yarn/bin/yarn /usr/local/bin/yarn && \
    ln -s /root/.yarn/bin/yarnpkg /usr/local/bin/yarnpkg

# Defina o diretório de trabalho
WORKDIR /rails

# Copie o código da aplicação
COPY . .

# Crie o arquivo .env temporariamente
RUN echo "DATABASE_NAME=biopark_companies" >> .env && \
    echo "DATABASE_USER=postgres" >> .env && \
    echo "DATABASE_PASSWORD=root" >> .env && \
    echo "DATABASE_HOST=localhost" >> .env && \
    echo "DATABASE_PORT=5432" >> .env && \
    echo "RECAPTCHA_SITE_KEY=6LeIxAcTAAAAAJcZVRqyHh71UMIEGNQ_MXjiZKhI" >> .env && \
    echo "RECAPTCHA_SECRET_KEY=6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe" >> .env

# Instale as gems do Ruby
RUN bundle install

# Instale as dependências do Yarn
RUN yarn install

# Exponha a porta padrão do Rails
EXPOSE 3000
