class AdminController < ApplicationController
  def index
    # Total de clientes
    @clientes = current_user.e_empresa.e_clientes.count

    # Contratos do mês atual
    mes_atual = Date.current.beginning_of_month..Date.current.end_of_month

    # Contratos pendentes (status que não seja "Aprovado" ou similar)
    status_pendente = GStatusContrato.where('descricao ILIKE ?', '%pendente%').first
    status_analise = GStatusContrato.where('descricao ILIKE ?',
                                           '%análise%').or(GStatusContrato.where('descricao ILIKE ?',
                                                                                 '%analise%')).first

    @contratos_pendentes = current_user.e_empresa.e_contratos
                                       .where(g_status_contrato_id: [status_pendente&.id, status_analise&.id].compact)
                                       .count

    # Comissões do mês
    @comissoes_mes = current_user.e_empresa.e_contratos
                                 .where(data_pagamento: mes_atual)
                                 .sum(:valor_comissao)

    # Metas do mês
    @meta_mes = current_user.e_empresa.e_metas
                            .where(referencia: Date.current.beginning_of_month)
                            .sum(:valor_meta)

    # Realizado no mês (soma das comissões)
    @realizado_mes = @comissoes_mes

    # Percentual de metas alcançadas
    @percentual_metas = @meta_mes > 0 ? ((@realizado_mes / @meta_mes) * 100).round(1) : 0

    # Contratos recentes (últimos 10)
    @contratos_recentes = current_user.e_empresa.e_contratos
                                      .includes(:e_cliente, :g_status_contrato, :user)
                                      .order(data_cadastro: :desc)
                                      .limit(10)

    # Crescimento do mês anterior
    mes_anterior = (Date.current - 1.month).beginning_of_month..(Date.current - 1.month).end_of_month
    comissoes_mes_anterior = current_user.e_empresa.e_contratos
                                         .where(data_pagamento: mes_anterior)
                                         .sum(:valor_comissao)

    @crescimento_comissoes = if comissoes_mes_anterior > 0
                               (((@comissoes_mes - comissoes_mes_anterior) / comissoes_mes_anterior) * 100).round(1)
                             else
                               0
                             end

    # Crescimento de clientes
    clientes_mes_anterior = current_user.e_empresa.e_clientes
                                        .where('created_at < ?', Date.current.beginning_of_month)
                                        .count

    clientes_novos = @clientes - clientes_mes_anterior
    @crescimento_clientes = if clientes_mes_anterior > 0
                              ((clientes_novos.to_f / clientes_mes_anterior) * 100).round(1)
                            else
                              0
                            end
  end

  def new
  end
end
