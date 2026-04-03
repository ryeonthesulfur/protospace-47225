class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?



private

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
end

end



=begin
  
ここに「authenticate_user!」を記述すると、投稿一覧やユーザー詳細が見れなくなり、
個別でコントローラーに「skip_before_action :authenticate_user!」を記述する必要が出てきてしまう。

今回は、投稿一覧やユーザー詳細は、ログインしていなくても見れるようにするため、
prototypes_controllerに「authenticate_user!」を記述した。

=end