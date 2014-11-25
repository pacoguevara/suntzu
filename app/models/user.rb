# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :full_name
  has_attached_file :image, :styles => { :medium => "300x300>", 
    :thumb => "24x24>" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_one :user, :foreign_key => parent
  belongs_to :municipality
  belongs_to :group
  has_many :documents, :dependent => :destroy
  has_many :list_votations
  accepts_nested_attributes_for :documents,  :allow_destroy => true


  validates_presence_of :role, :ife_key
  validates_uniqueness_of :ife_key
  # validates :cellphone, :numericality => {:only_integer => true}
  # validates :phone, :numericality => {:only_integer => true}

  ROLES_ADMIN =       %w[jugador enlace subenlace coordinador ]
  ROLES_COORDINADOR = %w[jugador enlace subenlace ]
  ROLES_ENLACE=       %w[jugador subenlace]
  ROLES_SUBENLACE =   %w[jugador]
  
  CELLS = {
    'rnm'=>1,
    'register_date'=>2,
    'ife_key'=>3,
    'bird'=>4,
    'name'=>5,
    'first_name'=>6,
    'last_name'=>7,
    'gender'=>8,
    'section'=>9, 
    'dto_fed'=>10,
    'dto_loc'=>11,
    'city_key'=>12,
    'city'=>13,
    'street_number'=>14,
    'outside_number'=>15,
    'internal_number'=>16,
    'neighborhood'=>17,
    'zipcode'=>18,
    'phone'=>19,
    'cellphone'=>20,
    'email'=>21,
  }
  self.per_page = 50

  def associate(file)
    spreadsheet = open_spreadsheet_2 file
    (1..spreadsheet.last_row).each do |i|
      if self.subenlace?
        User.where(:ife_key => spreadsheet.cell(i,1))
          .update_all :subenlace_id => self.id 
      elsif self.enlace_id?
        User.where(:ife_key => spreadsheet.cell(i,1))
          .update_all :subenlace_id => self.id 
      elsif self.coordinator_id
        User.where(:ife_key => spreadsheet.cell(i,1))
          .update_all :coordinador_id => self.id 
      end 
    end
  end
  def age
    now = Time.now.utc.to_date
    if !bird.nil?
      new_age = now.year - bird.year - ((now.month > bird.month || (now.month == bird.month && now.day >= bird.day)) ? 0 : 1)
    end
  end
  def admin?
  	self.role == "admin"
  end
  def jugador?
    self.role == "jugador"
  end
  def enlace?
    self.role == "enlace"
  end
  def subenlace?
    self.role == "subenlace"
  end
  def coordinador?
    self.role == "coordinador"
  end
  def grupo?
    self.role == "grupo"
  end
  def set_enlazado
    if !get_subenlace.nil?
      self.update_attribute(:subenlace_id, get_subenlace.id)
    end
    if !get_enlace.nil?
      self.update_attribute(:enlace_id, get_enlace.id)
    end
    if !get_coordinador.nil?
      self.update_attribute(:coordinador_id, get_coordinador.id)
    end
  end
  def get_deep
    return -1 if self.role == "admin"
    return 0 if self.role == "jugador"
    return 1 if self.role == "subenlace"
    return 2 if self.role == "enlace"
    return 3 if self.role == "coordinador"
  end
  def get_subenlace
    return nil if User.where(:id => self.parent).count < 1
    return User.find self.parent if self.parent != 0
  end
  def get_enlace
    return nil if self.parent == 0
    if self.get_deep == 0
      return nil if self.get_subenlace.nil?
      enlace_id = User.find(self.get_subenlace).parent
      return nil if enlace_id == 0
      return  User.find enlace_id
    elsif self.get_deep == 1
      return nil if self.get_subenlace.nil?
      return  User.find self.get_subenlace
    elsif self.get_deep == 2
      return nil if self.get_subenlace.nil?
      return  User.find self.get_subenlace
    end
  end
  def get_coordinador
    return nil if self.parent == 0 
    if self.get_deep == 0
      return nil if self.get_enlace.nil?
      return nil if self.get_enlace.parent == 0
      return  User.find self.get_enlace.parent
    elsif self.get_deep == 1
      coordinator_id = User.find(self.get_enlace).parent
      return nil if self.get_enlace.nil?
      return nil if coordinator_id == 0
      return  User.find coordinator_id
    elsif self.get_deep == 2
      return  User.find self.parent
    end
  end
  def full_name
    return "#{self.name} #{self.first_name} #{self.last_name}"
  end
  private
  def self.import 
    file_path=Rails.public_path.to_s + '/xls/users.xlsx'
    spreadsheet = open_spreadsheet(file_path)
    #(2..spreadsheet.last_row).each do |i|
    (2..spreadsheet.last_row).each do |i|
      puts spreadsheet.cell(i,CELLS['register_date'])
      save_row(spreadsheet, i)
    end
  end

  private
  def self.save_row(spreadsheet, i)
    User.connection
    user = User.new
    user.email = spreadsheet.cell(i, CELLS['email']) || ""
    user.name = spreadsheet.cell(i, CELLS['name']) || ""
    user.first_name = spreadsheet.cell(i,CELLS['first_name']) || ""
    user.last_name = spreadsheet.cell(i,CELLS['last_name'])  || ""
    user.cellphone = spreadsheet.cell(i,CELLS['cellphone']).to_i
    user.section = spreadsheet.cell(i,CELLS['section']) || ""
    user.zipcode = spreadsheet.cell(i,CELLS['zipcode']) || ""
    user.role = "jugador"
    user.register_date = spreadsheet.cell(i,CELLS['register_date']) || ""
    user.bird = spreadsheet.cell(i,CELLS['bird'])  || ""
    user.phone = spreadsheet.cell(i,CELLS['phone']).to_i
    user.age = spreadsheet.cell(i,CELLS['age']) || ""
    user.gender = spreadsheet.cell(i,CELLS['gender']) || ""
    user.city = spreadsheet.cell(i,CELLS['city']) || ""
    user.city_key = spreadsheet.cell(i,CELLS['city_key']) || ""
    user.street_number = spreadsheet.cell(i,CELLS['street_number']) || ""
    user.neighborhood = spreadsheet.cell(i,CELLS['neighborhood']) || ""
    user.dto_fed = spreadsheet.cell(i,CELLS['dto_fed']) || ""
    user.dto_loc = spreadsheet.cell(i,CELLS['dto_loc']) || ""
    user.internal_number = spreadsheet.cell(i,CELLS['internal_number']) || ""
    user.ife_key = spreadsheet.cell(i,CELLS['ife_key']) || ""
    user.outside_number = spreadsheet.cell(i,CELLS['outside_number']) || ""
    #user.password= '12345678'
    user.rnm=spreadsheet.cell(i,CELLS['rnm']) || ""
    user.parent = 0
    #user.password_confirmation= '12345678'
    user.save(validate: false)
  end
  def open_spreadsheet_2(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
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
  def self.array_to_xls( users )
    io = StringIO.new
    workbook = WriteExcel.new(io)
    
    worksheet  = workbook.add_worksheet
    
    worksheet.write(0, 0, 'RNM')
    worksheet.write(0, 1, 'Fecha Inicio')
    worksheet.write(0, 2, 'IFE')
    worksheet.write(0, 3, 'Fecha de Nacimiento')
    worksheet.write(0, 4, 'Nombre')
    worksheet.write(0, 5, 'Paterno')
    worksheet.write(0, 6, 'Materno')
    worksheet.write(0, 7, 'Sexo')
    worksheet.write(0, 8, 'Perfil')
    worksheet.write(0, 9, 'Grupo')
    worksheet.write(0, 10, 'Reporta a')
    worksheet.write(0, 11, 'Sección')
    worksheet.write(0, 12, 'Dto Fed')
    worksheet.write(0, 13, 'DtoLoc')
    worksheet.write(0, 14, 'CveMun')
    worksheet.write(0, 15, 'Municipio')
    worksheet.write(0, 16, 'Calle')
    worksheet.write(0, 17, 'NumExt')
    worksheet.write(0, 18, 'NumInt')
    worksheet.write(0, 19, 'Colonia')
    worksheet.write(0, 20, 'CP')
    worksheet.write(0, 21, 'Tel Particular')
    worksheet.write(0, 22, 'Celular')
    worksheet.write(0, 23, 'Email')

    i = 1
    users.each do |user|
      parent = user.parent == 0 ? "Sin Asignar" : User.find(user.parent).full_name
      worksheet.write(i, 0, user.rnm)
      worksheet.write(i, 1, user.register_date)
      worksheet.write(i, 2, user.ife_key)
      worksheet.write(i, 3, user.bird)
      worksheet.write(i, 4, user.name)
      worksheet.write(i, 5, user.first_name)
      worksheet.write(i, 6, user.last_name)
      worksheet.write(i, 7, user.gender)
      worksheet.write(i, 8, user.role)
      worksheet.write(i, 9, user.group_id.nil? ? "Sin Asignar" : user.group.name)
      worksheet.write(i, 10, parent)
      worksheet.write(i, 11, user.section)
      worksheet.write(i, 12, user.dto_fed)
      worksheet.write(i, 13, user.dto_loc)
      worksheet.write(i, 14, "")
      worksheet.write(i, 15, user.city)
      worksheet.write(i, 16, user.street_number)
      worksheet.write(i, 17, user.outside_number)
      worksheet.write(i, 18, user.internal_number)
      worksheet.write(i, 19, user.neighborhood)
      worksheet.write(i, 20, user.zipcode)
      worksheet.write(i, 21, user.phone)
      worksheet.write(i, 22, user.cellphone)
      worksheet.write(i, 23, user.email)


      i = i+1
    end

    workbook.close
    return io.string
  end 

  def self.dedupe
    # find all models and group them on keys which should be common
    grouped = all.group_by{ |model| model.ife_key }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end
  protected
  def email_required?
    false
  end
end