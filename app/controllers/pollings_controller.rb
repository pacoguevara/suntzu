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
    @listvotation = ListVotation.select("list_votations.*, users.*")
                    .where(:list_votation_header_id => @lvh.id)
                    .joins(:user).order(:number)
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
    @lvh = ListVotationHeader.find(params[:polling_id])
    @listvotation = ListVotation.select("list_votations.*, users.*")
        .where(:list_votation_header_id => @lvh.id)
        .joins(:user).order(:number)

      if params[:number] && params[:number] != "undefined"
        @listvotation = @listvotation.where(:number => params[:number]) 
    end

    if params[:name] && params[:name] != "undefined"
        @listvotation = @listvotation.where("lower(users.name) LIKE '%#{params[:name].downcase.strip}%'") 
    end

    if params[:first_name] && params[:first_name] != "undefined"
        @listvotation = @listvotation.where("lower(users.first_name) LIKE '%#{params[:first_name].downcase.strip}%'") 
    end

    if params[:last_name] && params[:last_name] != "undefined"
        @listvotation = @listvotation.where("lower(users.last_name) LIKE '%#{params[:last_name].downcase.strip}%'") 
    end

    if params[:section] && params[:section] != "undefined"
        @listvotation = @listvotation.where("users.section = '#{params[:section].to_i}'") 
    end

    if params[:municipality_id] && params[:municipality_id] != "undefined"
        @listvotation = @listvotation.where("users.municipality_id = '#{params[:municipality_id].to_i}'") 
    end

    if params[:subenlace] && params[:subenlace] != "undefined"
        @listvotation = @listvotation.where("users.subenlace_id = '#{params[:subenlace].to_i}'")  
    end

    if params[:enlace] && params[:enlace] != "undefined"
        @listvotation = @listvotation.where("users.enlace_id = '#{params[:enlace].to_i}'")  
    end

    if params[:coordinador] && params[:coordinador] != "undefined"
        @listvotation = @listvotation.where("users.coordinador_id = '#{params[:coordinador].to_i}'")  
    end

    if params[:group] && params[:group] != "undefined"
        @listvotation = @listvotation.where("users.group_id = '#{params[:group].to_i}'")  
    end

    @listvotation = @listvotation.order("users.subenlace_id")
    puts @listvotation
    io = StringIO.new
    workbook = WriteExcel.new(io)
    worksheet  = workbook.add_worksheet
    worksheet.write(0, 0, 'Numero')
    worksheet.write(0, 1, 'Nombre')
    worksheet.write(0, 2, 'Apellido paterno')
    worksheet.write(0, 3, 'Apellido materno')
    worksheet.write(0, 4, 'Edad')
    worksheet.write(0, 5, 'Sección')
    worksheet.write(0, 6, 'Municipio')
    worksheet.write(0, 7, 'Subenlace')
    worksheet.write(0, 8, 'Enlace')
    worksheet.write(0, 9, 'Coordinador')
    worksheet.write(0, 10, 'Grupo')
    worksheet.write(0, 11, 'Rol')

    i=1
    @listvotation.each do |l|
      worksheet.write(i, 0, l.number)
      worksheet.write(i, 1, l.user.name)
      worksheet.write(i, 2, l.user.first_name)
      worksheet.write(i, 3, l.user.last_name)
      worksheet.write(i, 4, l.user.age)
      worksheet.write(i, 5, l.user.section)
      worksheet.write(i, 6, l.user.city)
      worksheet.write(i, 7, l.user.subenlace_id != 0 ? User.find(l.user.subenlace_id).full_name : "Sin Asignar")
      worksheet.write(i, 8, l.user.enlace_id != 0 ? User.find(l.user.enlace_id).full_name : "Sin Asignar")
      worksheet.write(i, 9, l.user.coordinador_id != 0 ? User.find(l.user.coordinador_id).full_name : "Sin Asignar")
      worksheet.write(i, 10, l.user.get_group)
      worksheet.write(i, 11, l.user.role)
      i = i + 1
    end

    workbook.close
    send_data io.string, :filename =>"pollings_#{Time.now}.xls", 
      :type=> "application/vnd.ms-excel"
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
