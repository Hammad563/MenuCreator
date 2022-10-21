class SheetHelper
    file_url = Rails.root.join("menu-generator-365401-9cc627508d01.json").to_s 

    def initialize(sheet_key:)
        @sheet_key = sheet_key
    end


end