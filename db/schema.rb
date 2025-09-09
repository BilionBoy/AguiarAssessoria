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

ActiveRecord::Schema[7.2].define(version: 2025_09_09_034713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "e_clientes", force: :cascade do |t|
    t.bigint "e_empresa_id", null: false
    t.string "nome_completo", null: false
    t.string "cpf", null: false
    t.date "data_nascimento"
    t.string "email"
    t.string "telefone"
    t.string "nome_social"
    t.string "endereco"
    t.string "matricula"
    t.boolean "alfabetizado", default: false
    t.decimal "ultima_margem", precision: 10, scale: 2
    t.date "data_ultima_margem"
    t.integer "ano_admissao"
    t.boolean "pensionista", default: false
    t.string "numero_beneficio"
    t.boolean "possui_representante_legal", default: false
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.bigint "g_sexo_id"
    t.bigint "g_estado_id"
    t.bigint "g_cidade_id"
    t.bigint "g_bairro_id"
    t.bigint "g_orgao_id"
    t.bigint "g_margem_tipo_id"
    t.bigint "g_tipo_beneficio_id"
    t.bigint "g_status_cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_e_clientes_on_cpf", unique: true
    t.index ["e_empresa_id"], name: "index_e_clientes_on_e_empresa_id"
    t.index ["email"], name: "index_e_clientes_on_email"
    t.index ["g_bairro_id"], name: "index_e_clientes_on_g_bairro_id"
    t.index ["g_cidade_id"], name: "index_e_clientes_on_g_cidade_id"
    t.index ["g_estado_id"], name: "index_e_clientes_on_g_estado_id"
    t.index ["g_margem_tipo_id"], name: "index_e_clientes_on_g_margem_tipo_id"
    t.index ["g_orgao_id"], name: "index_e_clientes_on_g_orgao_id"
    t.index ["g_sexo_id"], name: "index_e_clientes_on_g_sexo_id"
    t.index ["g_status_cliente_id"], name: "index_e_clientes_on_g_status_cliente_id"
    t.index ["g_tipo_beneficio_id"], name: "index_e_clientes_on_g_tipo_beneficio_id"
  end

  create_table "e_empresas", force: :cascade do |t|
    t.string "razao_social"
    t.string "cnpj"
    t.string "endereco"
    t.string "email"
    t.string "telefone"
    t.bigint "g_cidade_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome_fantasia"
    t.index ["g_cidade_id"], name: "index_e_empresas_on_g_cidade_id"
  end

  create_table "g_bairros", force: :cascade do |t|
    t.string "descricao"
    t.bigint "g_cidade_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_cidade_id"], name: "index_g_bairros_on_g_cidade_id"
  end

  create_table "g_bancos", force: :cascade do |t|
    t.string "nome_fantasia"
    t.string "codigo"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_cidades", force: :cascade do |t|
    t.string "nome_fantasia"
    t.bigint "g_estado_id"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["g_estado_id"], name: "index_g_cidades_on_g_estado_id"
  end

  create_table "g_estados", force: :cascade do |t|
    t.string "nome_fantasia"
    t.string "sigla"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_margem_tipos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_orgaos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_sexos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_status_clientes", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_status_contratos", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_status_users", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_tipo_beneficios", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_tipo_operacoes", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "g_tipo_usuarios", force: :cascade do |t|
    t.string "descricao"
    t.string "created_by"
    t.string "updated_by"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nome_completo"
    t.string "cpf"
    t.string "telefone"
    t.bigint "g_tipo_usuario_id", null: false
    t.bigint "e_empresa_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_empresa_id"], name: "index_users_on_e_empresa_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["g_tipo_usuario_id"], name: "index_users_on_g_tipo_usuario_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "e_clientes", "e_empresas"
  add_foreign_key "e_clientes", "g_bairros"
  add_foreign_key "e_clientes", "g_cidades"
  add_foreign_key "e_clientes", "g_estados"
  add_foreign_key "e_clientes", "g_margem_tipos"
  add_foreign_key "e_clientes", "g_orgaos"
  add_foreign_key "e_clientes", "g_sexos"
  add_foreign_key "e_clientes", "g_status_clientes"
  add_foreign_key "e_clientes", "g_tipo_beneficios"
  add_foreign_key "e_empresas", "g_cidades"
  add_foreign_key "g_bairros", "g_cidades"
  add_foreign_key "g_cidades", "g_estados"
  add_foreign_key "users", "e_empresas"
  add_foreign_key "users", "g_tipo_usuarios"
end
