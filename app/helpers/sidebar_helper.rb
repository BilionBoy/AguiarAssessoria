module SidebarHelper
  def render_sidebar
    if current_user&.admin?
      render 'shared/sidebar/sidebar_admin'
    else
      render 'shared/sidebar/sidebar_user'
    end
  end
end
