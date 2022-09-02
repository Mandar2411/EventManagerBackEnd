class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    add_flash_types :danger, :info, :warning, :success
    
    def after_sign_in_path_for(resource)
        if current_user.user_role == 1
            root_path
        else
            events_path
        end
    end
end
