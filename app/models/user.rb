class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :user, :foreign_key => parent
  validates_presence_of :role
  ROLES_ADMIN =       %w[jugador enlace subenlace coordinador ]
  ROLES_COORDINADOR = %w[jugador enlace subenlace ]
  ROLES_ENLACE=       %w[jugador subenlace ]
  ROLES_SUBENLACE =   %w[jugador]
  
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
end
