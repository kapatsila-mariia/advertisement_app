class ApplicationController < ActionController::API

  def is_admin?
    current_user.role.name == 'admin'
  end
  
end
