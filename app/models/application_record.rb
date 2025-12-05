class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at created_by deleted_at descricao id nome updated_at updated_by nome_fantasia razao_social empresa e_empresa_id referencia
       titulo sigla numero_contrato]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[estabelecimento user]
  end

  def self.ransackable_associations(auth_object = nil)
    reflect_on_all_associations.map do |assoc|
      assoc.name.to_s
    end
  end
end
