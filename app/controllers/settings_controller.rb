class SettingsController < ApplicationController
    before_action :authenticate_user!

    def index 
    end

    def update
        current_user.update(settings_params)
        bypass_sign_in(current_user)
        redirect_to dashboard_path
    end

    private

    def settings_params
        params.require(:setting).permit(:email, :password)
    end

end
