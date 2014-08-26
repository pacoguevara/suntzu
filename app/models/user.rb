class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :user, :foreign_key => parent
  validates_presence_of :role, :parent
  ROLES_ADMIN =       %w[jugador enlace subenlace coordinador grupo]
  ROLES_COORDINADOR = %w[jugador enlace subenlace grupo]
  ROLES_ENLACE=       %w[jugador subenlace grupo]
  ROLES_SUBENLACE =   %w[jugador grupo]
  ROLES_GRUPO =   	  %w[grupo]
  self.per_page = 10
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
  
  validates :cellphone, :numericality => {:only_integer => true}
  validates :phone, :numericality => {:only_integer => true}
end
