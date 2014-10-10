class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :image, :styles => { :medium => "300x300>", 
    :thumb => "24x24>" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :user, :foreign_key => parent
  has_one :group
  has_many :documents, :dependent => :destroy
  accepts_nested_attributes_for :documents,  :allow_destroy => true


  validates_presence_of :role, :parent
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
  def get_deep
    return -1 if self.role == "admin"
    return 0 if self.role == "jugador"
    return 1 if self.role == "subenlace"
    return 2 if self.role == "enlace"
    return 3 if self.role == "coordinador"
  end
  def get_subenlace
    return User.find self.parent if self.parent != 0
  end
  def get_enlace
    return nil if self.parent == 0
    if self.get_deep == 0
      enlace_id = User.find(self.get_subenlace).parent
      return nil if enlace_id == 0
      return  User.find enlace_id
    elsif self.get_deep == 1
      return  User.find self.get_subenlace
    elsif self.get_deep == 2
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
    user.first_name= spreadsheet.cell(i,CELLS['first_name']) || ""
    user.last_name= spreadsheet.cell(i,CELLS['last_name'])  || ""
    user.cellphone= spreadsheet.cell(i,CELLS['cellphone']).to_i
    user.section= spreadsheet.cell(i,CELLS['section']) || ""
    user.zipcode= spreadsheet.cell(i,CELLS['zipcode']) || ""
    user.role= "jugador"
    user.register_date= spreadsheet.cell(i,CELLS['register_date']) || ""
    user.bird= spreadsheet.cell(i,CELLS['bird'])  || ""
    user.phone= spreadsheet.cell(i,CELLS['phone']).to_i
    user.age= spreadsheet.cell(i,CELLS['age']) || ""
    user.gender= spreadsheet.cell(i,CELLS['gender']) || ""
    user.city= spreadsheet.cell(i,CELLS['city']) || ""
    user.city_key= spreadsheet.cell(i,CELLS['city_key']) || ""
    user.street_number= spreadsheet.cell(i,CELLS['street_number']) || ""
    user.neighborhood= spreadsheet.cell(i,CELLS['neighborhood']) || ""
    user.dto_fed= spreadsheet.cell(i,CELLS['dto_fed']) || ""
    user.dto_loc= spreadsheet.cell(i,CELLS['dto_loc']) || ""
    user.internal_number= spreadsheet.cell(i,CELLS['internal_number']) || ""
    user.ife_key= spreadsheet.cell(i,CELLS['ife_key']) || ""
    user.outside_number= spreadsheet.cell(i,CELLS['outside_number']) || ""
    #user.password= '12345678'
    user.rnm=spreadsheet.cell(i,CELLS['rnm']) || ""
    user.parent = 0
    #user.password_confirmation= '12345678'
    user.save(validate: false)
  end
  def self.open_spreadsheet(file_path)
    case File.extname(file_path)
      when ".csv" then Csv.new(file_path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file_path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file_path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
 
  protected
  def email_required?
    false
  end
end