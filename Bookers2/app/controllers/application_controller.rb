class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # オンにする必要があるが、リダイレクトされるので一旦解除→再度つけた
  
  def after_sign_in_path_for(resource)
      user_path(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end
  # 新規登録の際に、nameも入れるようにした。deviseのストロングパラメーターは直接編集できないため、ここに書く。
end
