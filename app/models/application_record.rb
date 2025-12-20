class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    %w[
      id
      created_at
      updated_at
      deleted_at
      created_by

      descricao
      nome
      nome_completo
      email
      cpf

      nome_fantasia
      razao_social
      empresa
      referencia
      titulo
      sigla
      numero_contrato
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map(&:name)
  end
end
