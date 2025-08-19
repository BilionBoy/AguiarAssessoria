# config/initializers/inflections.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'g_tipo_usuario',   'g_tipo_usuarios'
  inflect.irregular 'g_sexo',           'g_sexos'
  inflect.irregular 'g_cidade',         'g_cidades'
  inflect.irregular 'g_estado',         'g_estados'
  inflect.irregular 'g_bairro',         'g_bairros'
  inflect.irregular 'g_orgao',          'g_orgaos'
end
