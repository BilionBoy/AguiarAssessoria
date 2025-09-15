module SidebarHelper
  def render_sidebar
    if can?(:access, :sidebar_admin)
      render 'shared/sidebar/sidebar_admin'
    elsif can?(:access, :sidebar_gerente)
      render 'shared/sidebar/sidebar_gerente'
    else
      render 'shared/sidebar/sidebar_user'
    end
  end
end
