module ValidacoesPorOrgao
  extend ActiveSupport::Concern

  included do
    validate :validacoes_por_orgao
  end

  private

  def validacoes_por_orgao
    return unless g_orgao&.descricao.present?

    case g_orgao.descricao.strip.downcase
    when 'Estado' then validar_estado!
    when 'Inss'   then validar_inss!
    end
  end

  def validar_estado!
    errors.add(:ano_admissao, :blank_estado) if ano_admissao.blank?
    errors.add(:pensionista,  :blank_estado) if pensionista.nil?
  end

  def validar_inss!
    errors.add(:numero_beneficio, :blank_inss) if numero_beneficio.blank?
    errors.add(:g_tipo_beneficio, :blank_inss) if g_tipo_beneficio_id.blank?
    errors.add(:possui_representante_legal, :blank_inss) if possui_representante_legal.nil?
  end
end
