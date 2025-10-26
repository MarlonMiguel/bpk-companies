# 🏷️ Sistema de Gerenciamento de Vendas | Biopark

Sistema feito em **Ruby on Rails** para gerenciamento de vendas dentro do ecossistema do **Biopark**, oferecendo controle de usuários, posts, categorias de produtos, aprovação de publicações, entre outras funcionalidades.

**EN:**  
System developed in **Ruby on Rails** for managing sales within the **Biopark** ecosystem, providing user management, posts, product categories, post approval, and other features.

---

## 🛠 Tecnologias Utilizadas

| Ferramenta | Versão |
|-----------|--------|
| Ruby      | **3.3.1** |
| Rails     | **7.1.4.1** |
| Bundler   | **2.5.10** |
| Banco de Dados | **PostgreSQL** |
| Gerenciador JS | Yarn ou NPM |

---

## ✨ Funcionalidades Principais

- 👤 Gerenciamento de usuários e permissões
- 📝 Criação e administração de posts
- 🗂 Organização por categorias de produtos
- ✅ Fluxo de aprovação antes da publicação
- 📦 Gerenciamento geral de vendas
- 📊 Painéis e relatórios (se houver)
- 🔐 Login, autenticação e controle de acesso

---

## 📦 Instalação e Configuração

### 1. Clone o repositório
```bash
git clone <url-do-repositorio>
cd <nome-do-projeto>
```

### 2. Instale as dependências Ruby
```bash
bundle install
```

### 3. Instale dependências JavaScript (se aplicável)
```bash
yarn install
# ou
npm install
```

---

## ⚙️ Configuração do Banco de Dados

Edite `config/database.yml` conforme seu ambiente PostgreSQL.

Crie e prepare o banco:

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed   # se houver seeds
```

Se preferir:

```bash
bin/rails db:setup   # create + migrate + seed
```

---

## 🔑 Configuração do `.env`

Crie um arquivo `.env` na raiz do projeto com as seguintes variáveis:

```
DATABASE_NAME=
DATABASE_USER=
DATABASE_PASSWORD=
DATABASE_HOST=
DATABASE_PORT=

RECAPTCHA_SITE_KEY=
RECAPTCHA_SECRET_KEY=

EMAIL_USERNAME=
EMAIL_PASSWORD=
```

---

## ▶️ Executando o Sistema

### Modo padrão:
```bash
bin/rails server
```

### Modo desenvolvimento integrado (recomendado):
```bash
bin/dev
```

Acesse no navegador:

```
http://localhost:3000
```

---

## 👤 Criando um Usuário Administrador

```bash
bin/rails console
```

```ruby
User.create!(
  email: "admin@example.com",
  password: "senha123",
  admin: true
)
```

---

## 🔄 Tarefas de Background (se o projeto usar Sidekiq)

```bash
redis-server
bundle exec sidekiq
```

Acesse painel Sidekiq (se configurado):
```
http://localhost:3000/sidekiq
```

---

## 🧪 Testes (se houver)

```bash
bundle exec rspec
```
ou
```bash
bin/rails test
```

---

## 📝 Licença

Este projeto é de uso interno do ecossistema Biopark.  
Distribuição externa somente mediante autorização.

---

## 🤝 Contribuição

Contribuições são bem-vindas!  
Crie um branch, faça alterações e abra um Pull Request.
