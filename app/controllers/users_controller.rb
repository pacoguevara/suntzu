class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]  
  def show
  end
  # GET /users/new
  def new
    @user = User.new
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
  
  # POST /users
  # POST /users.json
  def create
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
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
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
  	if params[:role] == 'jugador'
  		@users = User.all.limit(User.per_page).offset(0)
      @users_t = User.all
  	else
	    @users = User.where(:role => params[:role]).limit(User.per_page).offset(0)
      @users_t = User.where(:role => params[:role])
	end
  	@canedit = true
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:register_date, :first_name, :last_name, :name, :bird, :rnm, :linking, :sub_linking, :group_id, :suburb, :section, :sector, :cp, :phone, :cellphone, :email, :password, :password_confirmation, :role, :age, :gender, :city, :street_number, :neighborhood, :parent, :group_id)
  end
end
