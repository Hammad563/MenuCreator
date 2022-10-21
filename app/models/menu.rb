class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_items, dependent: :destroy

  validates :sheet_key, presence: true

  def self.create_with_sheet_key(user:, sheet_key:)
    menu = Menu.new(user: user, sheet_key: sheet_key)
    file_url = Rails.root.join("menu-generator-365401-9cc627508d01.json").to_s 
    session = GoogleDrive::Session.from_config(file_url)

    googleSpreadSheet = session.spreadsheet_by_key(sheet_key)
    ws = googleSpreadSheet.worksheets[0]
    keys = ws.rows.first
    values = ws.rows[1..-1]
    keys = keys.map { |key| key.parameterize(separator: "_")}.map(&:to_sym)

    menu.title = googleSpreadSheet.title
 



    ActiveRecord::Base.transaction do 
      menu.save!
      menu_item_attr = values.map do |item|
        {
          category: item[keys.find_index(:category)],
          item_name: item[keys.find_index(:item_name)],
          description: item[keys.find_index(:description)],
          price: item[keys.find_index(:price)],
          image_url: item[keys.find_index(:image_url)],
          menu_id: menu.id
        }
      end
      MenuItem.upsert_all(menu_item_attr)
    end
    menu

  end



  def sync!
    file_url = Rails.root.join("menu-generator-365401-9cc627508d01.json").to_s 
    session = GoogleDrive::Session.from_config(file_url)
    googleSpreadSheet = session.spreadsheet_by_key(sheet_key)
    ws = googleSpreadSheet.worksheets[0]
    keys = ws.rows.first
    values = ws.rows[1..-1]
    keys = keys.map { |key| key.parameterize(separator: "_")}.map(&:to_sym)

    ActiveRecord::Base.transaction do 
      save!
      menu_item_attr = values.map do |item|
        {
          category: item[keys.find_index(:category)],
          item_name: item[keys.find_index(:item_name)],
          description: item[keys.find_index(:description)],
          price: item[keys.find_index(:price)],
          image_url: item[keys.find_index(:image_url)],
          menu_id: self.id
        }
      end
      MenuItem.upsert_all(menu_item_attr, unique_by: [:menu_id, :item_name])
      item_names = values.map { |item| item[keys.find_index(:item_name)]}
      items_to_delete = MenuItem.pluck(:item_name) - item_names
      self.menu_items.where(item_name: items_to_delete).destroy_all
    end
    self
  end

  def build_qr_code
    RQRCode::QRCode.new()
  end




end
