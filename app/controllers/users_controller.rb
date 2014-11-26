class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]  
  def show
    user = User.find(params[:id])
    if user.role == "subenlace"
      @subordinados = User.where(:subenlace_id => params[:id])
    elsif user.role == "enlace"
      @subordinados = User.where(:enlace_id => params[:id])
    elsif user.role == "coordinador"
      @subordinados = User.where(:coordinador_id => params[:id])
    else
      @subordinados = []
    end
  end
  def import
    user = User.find params[:id]
    user.associate params[:file]
    respond_to do |format|
      format.html { redirect_to :back }
    end 
  end
  # GET /users/new
  def new
    @subenlaces = User.where(:role => 'subenlace')
    @enlaces = User.where(:role => 'enlace')
    @coordinadores = User.where(:role => 'coordinador')
    @municipalities = Municipality.all
    
    @user = User.new
    3.times {@user.documents.build }
    if current_user.admin? 
      @roles = User::ROLES_ADMIN
    end 
    if current_user.coordinador? 
      @roles = User::ROLES_COORDINADOR
    end 
    if current_user.enlace? 
      @roles = User::ROLES_ENLACE
    end 
    if current_user.subenlace? 
      @roles = User::ROLES_SUBENLACE
    end 
  end
  def lista_nominal
    @users = User.all.limit( User.per_page ).offset( 0 )
    @users_t = User.all
    @coordinators = User.where( :role => "coordinador")
    @links = User.where( :role => "enlace")
    @municipalities = Municipality.all.order( :name )
    @sub_links = User.where( :role => "subenlace")
    @polling = Polling.all
    @algo = ListVotationHeader.all
    if params && !params[:prueba].nil?
      puts "pos si hay params "+params[:prueba][:polling_id].to_s
      lvh = ListVotationHeader.new
      lvh.polling_id = params[:prueba][:polling_id]
      lvh.save

      @us = User.where("municipality_id = ? AND register_date >= ? AND register_date <= ? AND bird >= ? AND bird <=?",params[:prueba][:municipality_id], params[:prueba][:fecha_inicial_registro].to_date, params[:prueba][:fecha_final_registro].to_date, params[:prueba][:fecha_inicial_nacimiento].to_date, params[:prueba][:fecha_final_nacimiento].to_date)
      cont = 1
      @lvArray = Array.new
      @us.each do |u|
        newlv = ListVotation.new
        newlv.list_votation_header_id = lvh.id
        newlv.user_id = u.id
        newlv.number = cont
        cont+=1
        if u.temp_chek.nil?
          newlv.check = false
        else
          newlv.check = true
        end
        newlv.save(:validate=> false)
        @lvArray.push(newlv)
      end
      puts "es el user "+@us.to_s

    else
      puts "pos no hay params " +params.nil?.to_s
    end
  end
  # POST /users
  # POST /users.json
  def create
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if params[:user][:documents_attributes].blank? 
      params[:user].delete(:documents_attributes)
    else
      i=0
      if params[:user][:documents_attributes]["0"]['description'].blank?
        params[:user][:documents_attributes].delete "0"
      end
      if params[:user][:documents_attributes]["1"]['description'].blank?
        params[:user][:documents_attributes].delete "1"
      end
      if params[:user][:documents_attributes]["2"]['description'].blank?
        params[:user][:documents_attributes].delete "2"
      end
    end
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    #@user = User.find(params[:id])
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if params[:user][:documents_attributes].blank? 
      params[:user].delete(:documents_attributes)
    else
      i=0
      if params[:user][:documents_attributes]["0"]['description'].blank?
        params[:user][:documents_attributes].delete "0"
      end
      if params[:user][:documents_attributes]["1"]['description'].blank?
        params[:user][:documents_attributes].delete "1"
      end
      if params[:user][:documents_attributes]["2"]['description'].blank?
        params[:user][:documents_attributes].delete "2"
      end
    end
    
    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to(@user, notice: 'El usuario se ha actualizado.' )}
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @subenlaces = User.where(:role => 'subenlace')
    @enlaces = User.where(:role => 'enlace')
    @coordinadores = User.where(:role => 'coordinador')
    @municipalities = Municipality.all

    if @user.documents.count < 1
      3.times {@user.documents.build }
      #@user.documents.build
    else
      @user.documents.count..2.times {@user.documents.build }
    end
    if current_user.admin? 
      @roles = User::ROLES_ADMIN
    end 
    if current_user.coordinador? 
      @roles = User::ROLES_COORDINADOR
    end 
    if current_user.enlace? 
      @roles = User::ROLES_ENLACE
    end 
    if current_user.subenlace? 
      @roles = User::ROLES_SUBENLACE
    end 
    @sub_links = User.where(:role=>"subenlace")
    @links = User.where(:role=>"enlace")
    @codinators = User.where(:role=>"coordinador")
    @groups = User.where(:role=>"grupo")
  end

  def destroy
    @user_d = User.find params[:id]
    @user_d.delete
    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { head :no_content }
    end
  end

  def index
    @titles = {
      "jugador" => "Jugadores",
      "enlace" => "Enlaces",
      "subenlace" => "Subenlaces",
      "coordinador" => "Coordinadores"
    }
    @municipalities = Municipality.all.order( :name )
  	if params[:role] == 'jugador'
  		@users = User.all.limit(User.per_page).offset(0).order(:created_at)
      @users_t = User.all
  	else
	    @users = User.where(:role => params[:role]).limit(User.per_page).offset(0)
      @users_t = User.where(:role => params[:role])
	  end
    @subenlace = User.where(:role => "subenlace")
    @enlace = User.where(:role => "enlace")
    @coordinador = User.where(:role => "coordinador")
  	@canedit = true
  end
  def downloads
    users = User.where( :role => params[:role] )
    filename = "usuarios_#{params[:role]}.xls"
    send_data( User.array_to_xls( users), :filename => filename, 
      :type=> "application/vnd.ms-excel" )
  end
  def downloads_subordinados
    if params[:role] == "subenlace"
      users = User.where(:subenlace_id => params[:id])
    elsif params[:role] == "enlace"
      users = User.where(:enlace_id => params[:id])
    elsif params[:role] == "coordinador"
      users = User.where(:coordinador_id => params[:id])
    end
    filename = "subordinados_#{params[:role]}.xls"
    send_data( User.array_to_xls( users), :filename => filename, 
      :type=> "application/vnd.ms-excel" )
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:register_date, :first_name, :last_name, :name,
     :bird, :rnm, :linking, :sub_linking, :group_id, :suburb, :section, :sector,
      :cp, :phone, :cellphone, :email, :password, :password_confirmation, :role,
       :age, :gender, :city, :street_number, :neighborhood, :parent, :group_id, 
       :dto_fed, :dto_loc, :ife_key, :internal_number, :outside_number, :lat, 
       :lng, :fb, :tw,:image, :subenlace_id, :enlace_id, :coordinador_id, 
       :municipality_id, documents_attributes: [:user_id, :doc,:description])
  end
end