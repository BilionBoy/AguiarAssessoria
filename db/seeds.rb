# frozen_string_literal: true

puts '=== Iniciando seed logico do SimpliConsig ==='

ADMIN_EMAIL = 'dhiogoandre26@gmail.com'
ADMIN_PASSWORD = 'Dhiogo26122004'
ADMIN_CPF = '26122004000'
LEGACY_WRONG_ADMIN_EMAIL = 'dhioganre26@gmail.com'

# Todos os estados do Brasil (sigla => nome), para preencher o combo de UF em qualquer form.
BRAZIL_STATES = [
  %w[AC Acre], %w[AL Alagoas], %w[AP Amapa], %w[AM Amazonas], %w[BA Bahia],
  %w[CE Ceara], ['DF', 'Distrito Federal'], ['ES', 'Espirito Santo'], %w[GO Goias],
  %w[MA Maranhao], ['MT', 'Mato Grosso'], ['MS', 'Mato Grosso do Sul'], ['MG', 'Minas Gerais'],
  %w[PA Para], %w[PB Paraiba], %w[PR Parana], %w[PE Pernambuco], %w[PI Piaui],
  ['RJ', 'Rio de Janeiro'], ['RN', 'Rio Grande do Norte'], ['RS', 'Rio Grande do Sul'],
  %w[RO Rondonia], %w[RR Roraima], ['SC', 'Santa Catarina'], ['SP', 'Sao Paulo'],
  %w[SE Sergipe], %w[TO Tocantins]
].freeze

# Municipios de Rondonia (base operacional atual da empresa). Demais UFs ficam so com o
# registro do estado; municipios de outras UFs sao cadastrados manualmente quando surgir cliente la.
RONDONIA_CIDADES = [
  "Alta Floresta D'Oeste", 'Alto Alegre dos Parecis', 'Alto Paraiso', "Alvorada D'Oeste",
  'Ariquemes', 'Buritis', 'Cabixi', 'Cacaulandia', 'Cacoal', 'Campo Novo de Rondonia',
  'Candeias do Jamari', 'Castanheiras', 'Cerejeiras', 'Chupinguaia', 'Colorado do Oeste',
  'Corumbiara', 'Costa Marques', 'Cujubim', "Espigao D'Oeste", 'Governador Jorge Teixeira',
  'Guajara-Mirim', 'Itapua do Oeste', 'Jaru', 'Ji-Parana', "Machadinho D'Oeste",
  'Ministro Andreazza', 'Mirante da Serra', 'Monte Negro', "Nova Brasilandia D'Oeste",
  'Nova Mamore', 'Nova Uniao', 'Novo Horizonte do Oeste', 'Ouro Preto do Oeste', 'Parecis',
  'Pimenta Bueno', 'Pimenteiras do Oeste', 'Porto Velho', 'Presidente Medici',
  'Primavera de Rondonia', 'Rio Crespo', 'Rolim de Moura', "Santa Luzia D'Oeste",
  "Sao Felipe D'Oeste", 'Sao Francisco do Guapore', 'Sao Miguel do Guapore', 'Seringueiras',
  'Teixeiropolis', 'Theobroma', 'Urupa', 'Vale do Anari', 'Vale do Paraiso', 'Vilhena'
].freeze

def upsert_record(klass, find_by, attributes = {})
  record = klass.find_or_initialize_by(find_by)
  record.assign_attributes(attributes)
  record.save! if record.new_record? || record.changed?
  record
end

def catalog_record(klass, descricao, codigo: nil)
  record = if codigo.present? && klass.column_names.include?('codigo')
             klass.find_or_initialize_by(codigo: codigo)
           else
             klass.where('lower(descricao) = ?', descricao.downcase).first_or_initialize
           end

  record.descricao = descricao
  record.codigo = codigo if codigo.present? && record.respond_to?(:codigo=)
  record.save! if record.new_record? || record.changed?
  record
end

def merge_admin_duplicates_into!(admin)
  duplicate_admins = User
                     .where(email: LEGACY_WRONG_ADMIN_EMAIL)
                     .or(User.where(cpf: ADMIN_CPF))
                     .where.not(id: admin.id)

  duplicate_admins.find_each do |duplicate_admin|
    EContrato.where(user_id: duplicate_admin.id).update_all(user_id: admin.id, updated_at: Time.current)
    EMeta.where(user_id: duplicate_admin.id).update_all(user_id: admin.id, updated_at: Time.current)
    duplicate_admin.destroy!
  end
end

ActiveRecord::Base.transaction do
  # Usuarios e acesso
  tipo_admin = catalog_record(GTipoUsuario, 'Admin', codigo: GTipoUsuario::ADMIN)
  catalog_record(GTipoUsuario, 'Gerente', codigo: GTipoUsuario::GERENTE)
  catalog_record(GTipoUsuario, 'Usuario', codigo: GTipoUsuario::USUARIO)

  status_user_ativo = catalog_record(GStatusUser, 'Ativo', codigo: GStatusUser::ATIVO)
  catalog_record(GStatusUser, 'Inativo', codigo: GStatusUser::INATIVO)
  catalog_record(GStatusUser, 'Bloqueado', codigo: GStatusUser::BLOQUEADO)

  # Localizacao: todos os estados do Brasil, para o combo de UF nunca ficar incompleto.
  estados_por_sigla = BRAZIL_STATES.each_with_object({}) do |(sigla, nome), memo|
    memo[sigla] = upsert_record(GEstado, { sigla: sigla }, nome_fantasia: nome)
  end
  estado_ro = estados_por_sigla.fetch('RO')

  # Municipios: populados de fato so para Rondonia, onde a empresa opera hoje.
  cidades_ro_por_nome = RONDONIA_CIDADES.each_with_object({}) do |nome, memo|
    memo[nome] = upsert_record(GCidade, { nome_fantasia: nome, g_estado: estado_ro })
  end
  cidade_porto_velho = cidades_ro_por_nome.fetch('Porto Velho')

  upsert_record(GBairro, { descricao: 'Centro', g_cidade: cidade_porto_velho })
  upsert_record(GBairro, { descricao: 'Costa e Silva', g_cidade: cidade_porto_velho })

  # Tabelas de dominio usadas como FKs nos cadastros operacionais
  catalog_record(GSexo, 'Masculino')
  catalog_record(GSexo, 'Feminino')
  catalog_record(GSexo, 'Nao informado')

  catalog_record(GOrgao, 'Estado')
  catalog_record(GOrgao, 'INSS')
  catalog_record(GOrgao, 'Federal')
  catalog_record(GOrgao, 'Municipal')

  catalog_record(GTipoBeneficio, 'Aposentadoria')
  catalog_record(GTipoBeneficio, 'Pensao por morte')
  catalog_record(GTipoBeneficio, 'BPC/LOAS')
  catalog_record(GTipoBeneficio, 'Auxilio')

  catalog_record(GMargemTipo, 'Margem consignavel')
  catalog_record(GMargemTipo, 'Margem cartao')
  catalog_record(GMargemTipo, 'Cartao beneficio')

  catalog_record(GStatusCliente, 'Ativo')
  catalog_record(GStatusCliente, 'Em atendimento')
  catalog_record(GStatusCliente, 'Inativo')
  catalog_record(GStatusCliente, 'Bloqueado')

  catalog_record(GStatusContrato, 'Pendente')
  catalog_record(GStatusContrato, 'Em analise')
  catalog_record(GStatusContrato, 'Aprovado')
  catalog_record(GStatusContrato, 'Pago')
  catalog_record(GStatusContrato, 'Cancelado')
  catalog_record(GStatusContrato, 'Reprovado')

  catalog_record(GTipoOperacao, 'Novo contrato')
  catalog_record(GTipoOperacao, 'Refinanciamento')
  catalog_record(GTipoOperacao, 'Portabilidade')
  catalog_record(GTipoOperacao, 'Cartao beneficio')
  catalog_record(GTipoOperacao, 'Saque complementar')

  # Bancos com maior atuacao em credito consignado (INSS, servidores publicos e privado).
  upsert_record(GBanco, { codigo: '001' }, nome_fantasia: 'Banco do Brasil')
  upsert_record(GBanco, { codigo: '033' }, nome_fantasia: 'Santander')
  upsert_record(GBanco, { codigo: '104' }, nome_fantasia: 'Caixa Economica Federal')
  upsert_record(GBanco, { codigo: '237' }, nome_fantasia: 'Bradesco')
  upsert_record(GBanco, { codigo: '341' }, nome_fantasia: 'Itau')
  upsert_record(GBanco, { codigo: '623' }, nome_fantasia: 'Banco Pan')
  upsert_record(GBanco, { codigo: '626' }, nome_fantasia: 'C6 Bank')
  upsert_record(GBanco, { codigo: '041' }, nome_fantasia: 'Banrisul')
  upsert_record(GBanco, { codigo: '318' }, nome_fantasia: 'Banco BMG')
  upsert_record(GBanco, { codigo: '422' }, nome_fantasia: 'Banco Safra')
  upsert_record(GBanco, { codigo: '707' }, nome_fantasia: 'Banco Daycoval')
  upsert_record(GBanco, { codigo: '389' }, nome_fantasia: 'Banco Mercantil do Brasil')
  upsert_record(GBanco, { codigo: '069' }, nome_fantasia: 'Banco Crefisa')
  upsert_record(GBanco, { codigo: '096' }, nome_fantasia: 'Banco Bonsucesso Consignado')
  upsert_record(GBanco, { codigo: '121' }, nome_fantasia: 'Banco Agibank')
  upsert_record(GBanco, { codigo: '169' }, nome_fantasia: 'Banco Olé Consignado')
  upsert_record(GBanco, { codigo: '329' }, nome_fantasia: 'Banco Original')
  upsert_record(GBanco, { codigo: '077' }, nome_fantasia: 'Banco Inter')
  upsert_record(GBanco, { codigo: '212' }, nome_fantasia: 'Banco Master')
  upsert_record(GBanco, { codigo: '243' }, nome_fantasia: 'Banco Master (Multiplo)')
  upsert_record(GBanco, { codigo: '935' }, nome_fantasia: 'Facta Financeira')
  upsert_record(GBanco, { codigo: '756' }, nome_fantasia: 'Sicoob')
  upsert_record(GBanco, { codigo: '748' }, nome_fantasia: 'Sicredi')
  upsert_record(GBanco, { codigo: '290' }, nome_fantasia: 'PagBank')

  # Empresa base = Aguiar Assessoria Empresarial (correspondente bancario, Porto Velho/RO).
  empresa = upsert_record(
    EEmpresa,
    { cnpj: '19796117000151' },
    nome_fantasia: 'Aguiar Assessoria Empresarial',
    razao_social: 'Mylena P. Aguiar Brilhante LTDA',
    email: 'contato@aguiarassessoria.com.br',
    telefone: '(69) 99999-0000',
    endereco: 'Av. dos Imigrantes, 3463 - Costa e Silva, Porto Velho/RO, CEP 76803-611',
    g_cidade: cidade_porto_velho,
    created_by: ADMIN_EMAIL,
    updated_by: ADMIN_EMAIL
  )

  admin = User.find_by(email: ADMIN_EMAIL) ||
          User.find_by(email: LEGACY_WRONG_ADMIN_EMAIL) ||
          User.find_by(cpf: ADMIN_CPF) ||
          User.new

  merge_admin_duplicates_into!(admin) if admin.persisted?

  admin.email = ADMIN_EMAIL
  admin.assign_attributes(
    nome_completo: 'Dhiogo Administrador',
    cpf: ADMIN_CPF,
    telefone: '(27) 99999-2604',
    g_tipo_usuario: tipo_admin,
    g_status_user: status_user_ativo,
    e_empresa: empresa,
    password: ADMIN_PASSWORD,
    password_confirmation: ADMIN_PASSWORD
  )
  admin.save!

  puts '--- Seed logico criado/atualizado ---'
  puts "Empresa base: #{empresa.nome_fantasia}"
  puts "Admin: #{admin.email} / #{ADMIN_PASSWORD}"
  puts "Tipos de usuario: #{GTipoUsuario.count}"
  puts "Status de usuario: #{GStatusUser.count}"
  puts "Estados: #{GEstado.count}"
  puts "Municipios (RO): #{GCidade.count}"
  puts "Bancos: #{GBanco.count}"
  puts "Tipos de operacao: #{GTipoOperacao.count}"
end

puts '=== Seed logico do SimpliConsig finalizado com sucesso ==='
