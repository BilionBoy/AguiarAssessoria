module ValidacoesPorOrgao
  extend ActiveSupport::Concern

  included do
    validate :validacoes_por_orgao
  end

  private

  def validacoes_por_orgao
    g_orgaos.each do |orgao|
      case orgao.descricao.strip.downcase
      when 'estado'   then validar_estado!
      when 'inss'     then validar_inss!
      when 'federal'  then validar_federal!
      end
    end
  end

  def validar_estado!
    errors.add(:data_admissao, :blank) if data_admissao.blank?
  end

  def validar_inss!
    errors.add(:numero_beneficio, :blank) if numero_beneficio.blank?
    errors.add(:g_tipo_beneficio, :blank) if g_tipo_beneficio_id.blank?
  end

  def validar_federal!
    errors.add(:matricula, :blank) if matricula.blank?
  end
end
