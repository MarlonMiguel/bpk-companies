require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:admin) { create(:user, role: 'admin') } # Usuário administrador
  let(:user) { create(:user) } # Usuário comum
  let(:category) { create(:category) } # Supondo que você tenha uma model Category

  before do
    sign_in admin # Autentica o usuário admin antes de cada teste
  end

  describe "GET /users" do
    it "returns a successful response" do
      get users_path # Chama a rota para a ação index do UsersController
      expect(response).to have_http_status(:success) # Verifica se a resposta foi bem-sucedida
    end

    it "renders the index template" do
      get users_path
      expect(response).to render_template(:index) # Verifica se a template index foi renderizada
    end
  end

  describe "GET /users/:id" do
    it "shows the user" do
      get user_path(user) # Chama a rota para mostrar um usuário
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user.name) # Verifica se o nome do usuário está na resposta
    end
  end

  describe "POST /users/:id/update_categories" do
    it "updates the user's categories" do
      post update_categories_user_path(user), params: { user: { category_ids: [category.id] } }
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq('Categorias atualizadas com sucesso.') # Verifica a mensagem flash
      user.reload # Atualiza o usuário para verificar se as categorias foram atualizadas
      expect(user.category_ids).to include(category.id) # Verifica se a categoria foi adicionada
    end
  end

  describe "POST /users/:id/toggle_active" do
    it "toggles the user's active status" do
      post toggle_active_user_path(user) # Chama a rota para alternar o status do usuário
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq('Status alterado com sucesso.') # Verifica a mensagem flash
      user.reload # Atualiza o usuário
      expect(user.active?).to be_falsey # Verifica se o status foi alternado
    end
  end

  describe "PATCH /users/:id" do
    it "updates the user's profile" do
      patch user_path(user), params: { user: { name: "Novo Nome", phone: "987654321" } }
      expect(response).to redirect_to(users_path)
      expect(flash[:notice]).to eq('Perfil atualizado com sucesso.') # Verifica a mensagem flash
      user.reload # Atualiza o usuário para verificar se os dados foram alterados
      expect(user.name).to eq("Novo Nome") # Verifica se o nome foi atualizado
    end
  end

end
