# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.
puts '=== Iniciando seed do SimpliConsig ==='

# 1. ESTADOS
g_estado = GEstado.find_or_create_by!(nome_fantasia: 'Espírito Santo', sigla: 'ES')

# 2. CIDADES
g_cidade = GCidade.find_or_create_by!(nome_fantasia: 'Vitória', g_estado_id: g_estado.id)

# 3. BAIRROS
g_bairro = GBairro.find_or_create_by!(descricao: 'Centro', g_cidade_id: g_cidade.id)

# 4. TABELAS GERAIS
g_status_user = GStatusUser.find_or_create_by!(descricao: 'Ativo')
g_tipo_usuario = GTipoUsuario.find_or_create_by!(descricao: 'Administrador')

# 5. EMPRESA
empresa = EEmpresa.find_or_create_by!(
  nome_fantasia: 'Aguiar Assessoria',
  razao_social: 'Aguiar Assessoria LTDA',
  cnpj: '00.000.000/0001-00',
  email: 'contato@aguiar.com',
  telefone: '(27) 99999-9999',
  endereco: 'Centro, Vitória - ES',
  g_cidade_id: g_cidade.id
)

# 6. USUÁRIO ADMIN
User.find_or_create_by!(email: 'admin@admin.com') do |u|
  u.nome_completo = 'Administrador do Sistema'
  u.cpf = '00000000000'
  u.telefone = '(27) 99999-1111'
  u.password = '12345678'
  u.password_confirmation = '12345678'
  u.e_empresa_id = empresa.id
  u.g_tipo_usuario_id = g_tipo_usuario.id
  u.g_status_user_id = g_status_user.id
end

puts '=== SEED FINALIZADO COM SUCESSO ==='
