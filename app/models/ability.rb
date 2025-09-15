class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    if user.admin?
      can :manage, :all
      can :access, :sidebar_admin
    else
      # outros tipos de permissões podem ir aqui
      can :read, :home
      can :access, :sidebar_user
    end
  end
end
