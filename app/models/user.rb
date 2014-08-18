class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :user, :foreign_key => parent
  
  ROLES_ALL = %w[admin Jugador Enlace Subenlace Coordinador Candidato]
  ROLES_FILTER = %w[admin Jugador Enlace Subenlace Coordinador Candidato]
  
  def admin?
  	self.role == "admin"
  end
end
