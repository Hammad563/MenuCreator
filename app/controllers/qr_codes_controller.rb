class QrCodesController < ApplicationController
  layout "qr_menus"  

    def show
      @menu = Menu.find(params[:id])
    end
    
  end