class PollingsController < ApplicationController
  load_and_authorize_resource
  before_action :set_polling, only: [:show, :edit, :update, :destroy]

  # GET /pollings
  # GET /pollings.json
  def index
    @pollings = Polling.all
  end

  # GET /pollings/1
  # GET /pollings/1.json
  def show
  end

  # GET /pollings/new
  def new
    @polling = Polling.new
  end

  # GET /pollings/1/edit
  def edit
  end
  def detalle
    @groupsdropdown = Group.all
    @subenlaces = User.where(:role => 'subenlace')
    @enlaces = User.where(:role => 'enlace')
    @coordinadores = User.where(:role => 'coordinador')
    @municipalities = Municipality.all
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
    @lvh = ListVotationHeader.find(params[:polling_id])
    @listvotation = ListVotation.select("list_votations.id AS lid, list_votations.*, users.*")
                    .where(:list_votation_header_id => @lvh.id)
                    .joins(:user).order(:number).limit(User.per_page).offset(0)
  end

  # POST /pollings
  # POST /pollings.json
  def create
    @polling = Polling.new(polling_params)

    respond_to do |format|
      if @polling.save
        format.html { redirect_to @polling, notice: 'Polling was successfully created.' }
        format.json { render action: 'show', status: :created, location: @polling }
      else
        format.html { render action: 'new' }
        format.json { render json: @polling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pollings/1
  # PATCH/PUT /pollings/1.json
  def update
    respond_to do |format|
      if @polling.update(polling_params)
        format.html { redirect_to @polling, notice: 'Polling was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @polling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pollings/1
  # DELETE /pollings/1.json
  def destroy
    @polling.destroy
    respond_to do |format|
      format.html { redirect_to pollings_url }
      format.json { head :no_content }
    end
  end

  def download_xls
    Polling.download_xls(params)
    flash[:notice] = 'La lista nominal se enviará por correo electrónico una vez que sea procesada'
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_polling
      @polling = Polling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def polling_params
      params.require(:polling).permit(:name, :start_date, :end_date)
    end
end
