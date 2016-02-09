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
  belongs_to :user_message


  validates_presence_of :role, :ife_key
  validates_uniqueness_of :ife_key
  # validates :cellphone, :numericality => {:only_integer => true}
  # validates :phone, :numericality => {:only_integer => true}

  ROLES_ADMIN =       %w[jugador enlace subenlace coordinador ]
  ROLES_COORDINADOR = %w[jugador enlace subenlace ]
  ROLES_ENLACE=       %w[jugador subenlace]
  ROLES_SUBENLACE =   %w[jugador]

  ROLES_ADMIN_DROPDOWN =       %w[[jugador, 1] [enlace, 1] [subenlace,1] [coordinador,1] ]
  ROLES_COORDINADOR_DROPDOWN = %w[[jugador, 1] [enlace, 1] [subenlace,1] ]
  ROLES_ENLACE_DROPDOWN=       %w[[jugador, 1] [subenlace, 1]]
  ROLES_SUBENLACE_DROPDOWN =   %w[[jugador, 1]]

  CELLS = {
    'rnm'=>25,
    'register_date'=>24,
    'ife_key'=>2,
    'bird'=>31,
    'name'=>8,
    'first_name'=>6,
    'last_name'=>7,
    'gender'=>27,
    'section'=>26,
    'dto_fed'=>21,
    'dto_loc'=>22,
    'city_key'=>31,
    'city'=>9,
    'street_number'=>12,
    'outside_number'=>13,
    'internal_number'=>14,
    'neighborhood'=>18,
    'zipcode'=>17,
    'phone'=>28,
    'cellphone'=>16,
    'email'=>31,
    'age'=>23
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
  def communication?
    self.role == "communication"
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
  def get_group
    return "Sin grupo" if self.group_id == nil || self.group_id == 0
    return Group.find(self.group_id).name
  end

  def update_subordinados
    if self.role == "subenlace"
      users = User.where(:subenlace_id => self.id)
      users.each do |u|
        u.enlace_id = self.enlace_id
        u.coordinador_id = self.coordinador_id
        u.group_id = self.group_id
        u.save
      end
    elsif self.role == "enlace"
      users = User.where(:enlace_id => self.id)
      users.each do |u|
        u.enlace_id = self.id
        u.coordinador_id = self.coordinador_id
        u.group_id = self.group_id
        u.save
      end
    elsif self.role == "coordinador"
      users = User.where(:coordinador_id => self.id)
      users.each do |u|

        u.coordinador_id = self.id
        u.group_id = self.group_id
        u.save
      end
    end
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

  def self.save_user_municipality
    municipalities = Municipality.all
    municipalities.each do |mun|
      mun_name = mun.name.downcase.gsub(/[\s,]+/, "")
      user = User.new
      user.name = mun.name
      user.first_name = mun.name
      user.email = mun_name + "@pan.gob.mx"
      user.password = mun_name + "2015"
      user.password_confirmation = mun_name + "2015"
      user.ife_key = mun_name + "12345"
      user.city = mun.name
      user.municipality_id = mun.id
      user.role = "communication"
      user.save
    end
  end

  def full_name
    return "#{self.name} #{self.first_name} #{self.last_name}"
  end

  private
  def self.import
    file_path=Rails.public_path.to_s + '/xls/users2.xlsx'
    spreadsheet = open_spreadsheet(file_path)
    #(2..spreadsheet.last_row).each do |i|
    ifes = []
    count = 0
    (2..spreadsheet.last_row).each do |i|
      puts spreadsheet.cell(i,CELLS['register_date'])
      ife_k = spreadsheet.cell(i,CELLS['ife_key'])


      if !User.exists?(:ife_key => ife_k)
        save_row(spreadsheet, i)
      else
        count = count + 1
        ifes.push(i)
      end
    end
    puts count
    puts ifes
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
    #user.municipality_id = spreadsheet.cell(i,CELLS['city_key']) || ""
    city_name = spreadsheet.cell(i,CELLS['city']) || ""
    puts city_name
    mun_id = Municipality.get_city_key(city_name)
    user.municipality_id = mun_id
    puts mun_id
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
    #worksheet.write(0, 10, 'Reporta a')
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
      #parent = user.parent == 0 ? "Sin Asignar" : User.find(user.parent).full_name
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
      #worksheet.write(i, 10, parent)
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

  def self.import_candidates(file, role)
    spreadsheet = open_spreadsheet(file)
    if role == "coordinador"
      folio = 120000
    elsif role == "enlace"
      folio = 110000
    else
      folio = 100000
    end

    (2..spreadsheet.last_row).each do |i|
      #puts spreadsheet.cell(i,1)
      folio = spreadsheet.cell(i,1)
      name = spreadsheet.cell(i,2)
      if !name.nil? || !name.blank?
        user = User.new
        user.email = name.downcase.gsub(/\s+/, "")+"@pan.gob.mx"
        user.name = name
        #user.ife_key = folio+i
        user.ife_key = folio
        user.role = role
        user.save(validate: false)
      end
    end
  end

  def self.find_by_name_and_role(name, role)
    user = User.where(:name => name, :role => role)
    if user.first.nil?
      return nil
    else
      return user.first.id
    end
  end

  def self.import_players(file)
    spreadsheet = open_spreadsheet(file)
    coordinadores = {}
    enlaces = {}
    subenlaces = {}

    @_coordinadores = User.where(:role => 'coordinador')
    @_enlaces = User.where(:role => 'enlace')
    @_subenlaces = User.where(:role => 'subenlace')

    @_coordinadores.each do |coord|
      coordinadores[coord.name] = coord.id
    end

    @_enlaces.each do |enl|
      enlaces[enl.name] = enl.id
    end

    @_subenlaces.each do |sub|
      subenlaces[sub.name] = sub.id
    end

    puts coordinadores
    puts enlaces
    puts subenlaces

    (2..spreadsheet.last_row).each do |i|
      folio = spreadsheet.cell(i,1).to_i.to_s
      first_name = spreadsheet.cell(i,9)
      last_name = spreadsheet.cell(i,10)
      name = spreadsheet.cell(i,11)
      #coord_name = spreadsheet.cell(i,5)
      enlace_name = spreadsheet.cell(i,3)
      subenlace_name = spreadsheet.cell(i,4)
      municipality = spreadsheet.cell(i,12)
      street_number = spreadsheet.cell(i,15)
      outside_number = spreadsheet.cell(i,16)
      internal_number = spreadsheet.cell(i,17)
      neighborhood = spreadsheet.cell(i,21)
      zipcode = spreadsheet.cell(i,13)
      cellphone = spreadsheet.cell(i,19)
      phone = spreadsheet.cell(i,31)
      email = spreadsheet.cell(i, 32)
      ife_key = spreadsheet.cell(i, 5)

      # if coordinadores.has_key?(coord_name)
      #   coord_id = coordinadores[coord_name]
      # else
      #   coord_id = nil
      # end

      if enlaces.has_key?(enlace_name)
        enlace_id = enlaces[enlace_name]
      else
        enlace_id = nil
      end

      if subenlaces.has_key?(subenlace_name)
        subenlace_id = subenlaces[subenlace_name]
      else
        subenlace_id = nil
      end


      if !name.nil? & !name.blank?
        puts "Folio: #{folio}"
        #puts "coordinador #{coord_id}"
        puts "enlace: #{enlace_id}"
        puts "subenlace: #{subenlace_id}"
        puts "================================="
        user = User.new
        user.email = name.strip+"@pan.gob.mx"
        user.name = name
        user.first_name = first_name
        user.last_name = last_name
        if User.exists?(:ife_key => ife_key)
          user.ife_key = ife_key+"b"
        else
          user.ife_key = ife_key
        end
        user.role = "jugador"
        #user.coordinador_id = coord_id
        user.enlace_id = enlace_id
        user.subenlace_id = subenlace_id
        user.municipality_id = Municipality.get_city_key(municipality)
        user.city = municipality
        user.street_number = street_number
        user.outside_number = outside_number
        user.internal_number = internal_number
        user.neighborhood = neighborhood
        user.zipcode = zipcode.to_i.to_s
        user.cellphone = cellphone
        user.phone = phone
        user.email = email
        user.save(validate: false)
      end
    end
  end

  def self.download_sub(params)
    if params[:role] == "subenlace"
      users = User.where(:subenlace_id => params[:id])
    elsif params[:role] == "enlace"
      users = User.where(:enlace_id => params[:id])
    elsif params[:role] == "coordinador"
      users = User.where(:coordinador_id => params[:id])
    end
    filename = "subordinados_#{params[:role]}.xls"
    file = User.array_to_xls( users)

    mail = UserMailer.download_subordinados(file, filename)
    mail.deliver
  end
  protected
  def email_required?
    false
  end
end
