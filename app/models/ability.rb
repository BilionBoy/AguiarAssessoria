class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
      can :access, :sidebar_admin
    elsif user.gerente?
      # gerente só enxerga essas entidades
      can :read, EContrato
      can :read, ECliente
      can :read, GBanco
      can :access, :sidebar_gerente
    else
      # usuários comuns
      can :read, :home
      can :access, :sidebar_user
    end
  end
end
