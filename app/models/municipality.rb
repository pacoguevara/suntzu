class Municipality < ActiveRecord::Base
	self.primary_key = 'id'
	has_one :user
	validates_uniqueness_of :id
	CELLS = {
    'ife_key'=>3,
    'city_key'=>12
  }
	def self.update
		file_path = Rails.public_path.to_s + '/xls/users.xlsx'
    spreadsheet = open_spreadsheet(file_path)
    #(2..spreadsheet.last_row).each do |i|
    (2..spreadsheet.last_row).each do |i|
      ife_key  = spreadsheet.cell(i,CELLS['ife_key']) || ""
      city_key = spreadsheet.cell(i,CELLS['city_key']) || ""
      user = User.where(:ife_key => ife_key).first
      city_key = city_key.to_i
      user.update_attribute :municipality_id, city_key
    end
	end

	def self.open_spreadsheet(file_path)
    case File.extname(file_path)
      when ".csv" then Csv.new(file_path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file_path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file_path, nil, :ignore)
      else raise "Unknown file type: #{file_path}"
    end
  end

  def self.get_city_key(mun)
    municipality = Municipality.where(:name => mun).first
    if !municipality.nil?
      return municipality.id
    else
      return ''
    end
  end

  def self.import_from_xls(file)
    spreadsheet = open_spreadsheet(file)
    (2..spreadsheet.last_row).each do |i|
      municipality  = spreadsheet.cell(i,1) 
      self.create(:name => municipality, :id => i)
    end
  end
end
