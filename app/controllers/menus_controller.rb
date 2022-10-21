class MenusController < ApplicationController
    before_action :authenticate_user!
    
    def index
    end
    
    def new 
        @menu = Menu.new
    end

    def create
        @menu = Menu.create_with_sheet_key(user: current_user, sheet_key: menu_params[:sheet_key])
        if @menu.persisted?
            redirect_to dashboard_path
        else
            flash.now[:error] = @menu.errors.full_messages.to_sentence
            render :new
        end
    end

    def show
        @menu = Menu.find(params[:id])
    end

    def update
        @menu = Menu.find(params[:id])
        @menu.sync!
        redirect_to dashboard_path
    end

    def destroy
        @menu = Menu.find(params[:id])
        @menu.destroy
        redirect_to dashboard_path
    end

    private

    def menu_params
        params.require(:menu).permit(:title, :sheet_key)
    end

end
