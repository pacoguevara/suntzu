class City < ActiveRecord::Base
	validates_uniqueness_of :name
	def self.open_spreadsheet(file_path)
    case File.extname(file_path)
      when ".csv" then Csv.new(file_path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file_path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file_path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
  def self.import 
    file_path = Rails.public_path.to_s + '/xls/users.xlsx'
    spreadsheet = open_spreadsheet(file_path)
    #(2..spreadsheet.last_row).each do |i|
    (2..spreadsheet.last_row).each do |i|
      save_row(spreadsheet, i)
    end
  end

  def self.save_row(spreadsheet, i)
    city = City.new
    city.key  = spreadsheet.cell(i, 12) || ""
    city.name = spreadsheet.cell(i, 13) || ""
    city.save
  end
end