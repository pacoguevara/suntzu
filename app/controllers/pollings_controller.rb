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
    order = 0
    @lvh = ListVotationHeader.find(params[:polling_id])
    @listvotation = ListVotation.select("list_votations.*, users.*")
        .where(:list_votation_header_id => @lvh.id)
        .joins(:user)

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
        order = 3
    end

    if params[:enlace] && params[:enlace] != "undefined"
        @listvotation = @listvotation.where("users.enlace_id = '#{params[:enlace].to_i}'")  
        order = 2
    end

    if params[:coordinador] && params[:coordinador] != "undefined"
        @listvotation = @listvotation.where("users.coordinador_id = '#{params[:coordinador].to_i}'") 
        order = 1
    end

    if params[:group] && params[:group] != "undefined"
        @listvotation = @listvotation.where("users.group_id = '#{params[:group].to_i}'")  
    end

    

    @listvotation = @listvotation.order("users.enlace_id, users.subenlace_id")
    puts @listvotation
    io = StringIO.new
    workbook = WriteExcel.new(io)
    worksheet  = workbook.add_worksheet
    worksheet.write(0, 0, 'Numero')
    worksheet.write(0, 1, 'Nombre')
    worksheet.write(0, 2, 'Apellido paterno')
    worksheet.write(0, 3, 'Apellido materno')
    worksheet.write(0, 4, 'Edad')
    worksheet.write(0, 5, 'Calle')
    worksheet.write(0, 6, 'No. Interior')
    worksheet.write(0, 7, 'No. Exterio')
    worksheet.write(0, 8, 'Colonia')
    worksheet.write(0, 9, 'Sección')
    worksheet.write(0, 10, 'Municipio')
    worksheet.write(0, 11, 'Subenlace')
    worksheet.write(0, 12, 'Enlace')
    worksheet.write(0, 13, 'Coordinador')
    worksheet.write(0, 14, 'Grupo')
    worksheet.write(0, 15, 'Rol')
    worksheet.write(0, 16, 'Voto')

    i=1

    if order == 1
      @enlaces = @listvotation.where("users.coordinador_id != 0 AND users.role = 'enlace'")
      @enlaces.each do |l|
        worksheet.write(i, 0, l.number)
        worksheet.write(i, 1, l.user.name)
        worksheet.write(i, 2, l.user.first_name)
        worksheet.write(i, 3, l.user.last_name)
        worksheet.write(i, 4, l.user.age)
        worksheet.write(i, 5, l.user.street_number)
        worksheet.write(i, 6, l.user.internal_number)
        worksheet.write(i, 7, l.user.outside_number)
        worksheet.write(i, 8, l.user.neighborhood)
        worksheet.write(i, 9, l.user.section)
        worksheet.write(i, 10, l.user.city)
        worksheet.write(i, 11, l.user.subenlace_id != 0 ? User.find(l.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, l.user.enlace_id != 0 ? User.find(l.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, l.user.coordinador_id != 0 ? User.find(l.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, l.user.get_group)
        worksheet.write(i, 15, l.user.role)
        worksheet.write(i, 16, l.check ? "Si" : "NO")
        i = i + 1
        @subenlaces = @listvotation.where("users.enlace_id = #{l.user.id} AND users.role = 'subenlace'")
        @subenlaces.each do |s|
          worksheet.write(i, 0, s.number)
          worksheet.write(i, 1, s.user.name)
          worksheet.write(i, 2, s.user.first_name)
          worksheet.write(i, 3, s.user.last_name)
          worksheet.write(i, 4, s.user.age)
          worksheet.write(i, 5, s.user.street_number)
          worksheet.write(i, 6, s.user.internal_number)
          worksheet.write(i, 7, s.user.outside_number)
          worksheet.write(i, 8, s.user.neighborhood)
          worksheet.write(i, 9, s.user.section)
          worksheet.write(i, 10, s.user.city)
          worksheet.write(i, 11, s.user.subenlace_id != 0 ? User.find(s.user.subenlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 12, s.user.enlace_id != 0 ? User.find(s.user.enlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 13, s.user.coordinador_id != 0 ? User.find(s.user.coordinador_id).full_name : "Sin Asignar")
          worksheet.write(i, 14, s.user.get_group)
          worksheet.write(i, 15, s.user.role)
          worksheet.write(i, 16, s.check ? "Si" : "NO")
          i = i + 1
          @jugadores = @listvotation.where("users.subenlace_id = #{s.user.id} AND users.role = 'jugador'")
          @jugadores.each do |j|
            worksheet.write(i, 0, j.number)
            worksheet.write(i, 1, j.user.name)
            worksheet.write(i, 2, j.user.first_name)
            worksheet.write(i, 3, j.user.last_name)
            worksheet.write(i, 4, j.user.age)
            worksheet.write(i, 5, j.user.street_number)
            worksheet.write(i, 6, j.user.internal_number)
            worksheet.write(i, 7, j.user.outside_number)
            worksheet.write(i, 8, j.user.neighborhood)
            worksheet.write(i, 9, j.user.section)
            worksheet.write(i, 10, j.user.city)
            worksheet.write(i, 11, j.user.subenlace_id != 0 ? User.find(j.user.subenlace_id).full_name : "Sin Asignar")
            worksheet.write(i, 12, j.user.enlace_id != 0 ? User.find(j.user.enlace_id).full_name : "Sin Asignar")
            worksheet.write(i, 13, j.user.coordinador_id != 0 ? User.find(j.user.coordinador_id).full_name : "Sin Asignar")
            worksheet.write(i, 14, j.user.get_group)
            worksheet.write(i, 15, j.user.role)
            worksheet.write(i, 16, j.check ? "Si" : "NO")
            i = i + 1
          end
        end
        @jugadores_no_sub = @listvotation.where("users.subenlace_id = 0 AND users.enlace_id = #{l.user.id} AND users.role = 'jugador'")
        @jugadores_no_sub.each do |no_s|
          worksheet.write(i, 0, no_s.number)
          worksheet.write(i, 1, no_s.user.name)
          worksheet.write(i, 2, no_s.user.first_name)
          worksheet.write(i, 3, no_s.user.last_name)
          worksheet.write(i, 4, no_s.user.age)
          worksheet.write(i, 5, no_s.user.street_number)
          worksheet.write(i, 6, no_s.user.internal_number)
          worksheet.write(i, 7, no_s.user.outside_number)
          worksheet.write(i, 8, no_s.user.neighborhood)
          worksheet.write(i, 9, no_s.user.section)
          worksheet.write(i, 10, no_s.user.city)
          worksheet.write(i, 11, no_s.user.subenlace_id != 0 ? User.find(no_s.user.subenlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 12, no_s.user.enlace_id != 0 ? User.find(no_s.user.enlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 13, no_s.user.coordinador_id != 0 ? User.find(no_s.user.coordinador_id).full_name : "Sin Asignar")
          worksheet.write(i, 14, no_s.user.get_group)
          worksheet.write(i, 15, no_s.user.role)
          worksheet.write(i, 16, no_s.check ? "Si" : "NO")
          i = i + 1
        end
      end
      @subenlaces_no_enlace = @listvotation.where("users.coordinador_id != 0 AND users.role = 'subenlace' AND users.enlace_id = 0")
      @subenlaces_no_enlace.each do |sbne|
        worksheet.write(i, 0, sbne.number)
        worksheet.write(i, 1, sbne.user.name)
        worksheet.write(i, 2, sbne.user.first_name)
        worksheet.write(i, 3, sbne.user.last_name)
        worksheet.write(i, 4, sbne.user.age)
        worksheet.write(i, 5, sbne.user.street_number)
        worksheet.write(i, 6, sbne.user.internal_number)
        worksheet.write(i, 7, sbne.user.outside_number)
        worksheet.write(i, 8, sbne.user.neighborhood)
        worksheet.write(i, 9, sbne.user.section)
        worksheet.write(i, 10, sbne.user.city)
        worksheet.write(i, 11, sbne.user.subenlace_id != 0 ? User.find(sbne.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, sbne.user.enlace_id != 0 ? User.find(sbne.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, sbne.user.coordinador_id != 0 ? User.find(sbne.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, sbne.user.get_group)
        worksheet.write(i, 15, sbne.user.role)
        worksheet.write(i, 16, sbne.check ? "Si" : "NO")
        i = i + 1
        @jugadores_nosbne = @listvotation.where("users.subenlace_id = #{sbne.user.id} AND users.role = 'jugador'")
          @jugadores_nosbne.each do |nos|
            worksheet.write(i, 0, nos.number)
            worksheet.write(i, 1, nos.user.name)
            worksheet.write(i, 2, nos.user.first_name)
            worksheet.write(i, 3, nos.user.last_name)
            worksheet.write(i, 4, nos.user.age)
            worksheet.write(i, 5, nos.user.street_number)
            worksheet.write(i, 6, nos.user.internal_number)
            worksheet.write(i, 7, nos.user.outside_number)
            worksheet.write(i, 8, nos.user.neighborhood)
            worksheet.write(i, 9, nos.user.section)
            worksheet.write(i, 10, nos.user.city)
            worksheet.write(i, 11, nos.user.subenlace_id != 0 ? User.find(nos.user.subenlace_id).full_name : "Sin Asignar")
            worksheet.write(i, 12, nos.user.enlace_id != 0 ? User.find(nos.user.enlace_id).full_name : "Sin Asignar")
            worksheet.write(i, 13, nos.user.coordinador_id != 0 ? User.find(nos.user.coordinador_id).full_name : "Sin Asignar")
            worksheet.write(i, 14, nos.user.get_group)
            worksheet.write(i, 15, nos.user.role)
            worksheet.write(i, 16, nos.check ? "Si" : "NO")
            i = i + 1
          end
      end
      @jugadores_no = @listvotation.where("users.role = 'jugador' AND users.subenlace_id = 0 AND users.enlace_id = 0")
      @jugadores_no.each do |no|
        worksheet.write(i, 0, no.number)
        worksheet.write(i, 1, no.user.name)
        worksheet.write(i, 2, no.user.first_name)
        worksheet.write(i, 3, no.user.last_name)
        worksheet.write(i, 4, no.user.age)
        worksheet.write(i, 5, no.user.street_number)
        worksheet.write(i, 6, no.user.internal_number)
        worksheet.write(i, 7, no.user.outside_number)
        worksheet.write(i, 8, no.user.neighborhood)
        worksheet.write(i, 9, no.user.section)
        worksheet.write(i, 10, no.user.city)
        worksheet.write(i, 11, no.user.subenlace_id != 0 ? User.find(no.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, no.user.enlace_id != 0 ? User.find(no.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, no.user.coordinador_id != 0 ? User.find(no.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, no.user.get_group)
        worksheet.write(i, 15, no.user.role)
        worksheet.write(i, 16, no.check ? "Si" : "NO")
        i = i + 1
      end 
    end

    if order == 2
      @subenlaces = @listvotation.where("users.enlace_id = #{params[:enlace]} AND users.role = 'subenlace'")
      @subenlaces.each do |l|
        worksheet.write(i, 0, l.number)
        worksheet.write(i, 1, l.user.name)
        worksheet.write(i, 2, l.user.first_name)
        worksheet.write(i, 3, l.user.last_name)
        worksheet.write(i, 4, l.user.age)
        worksheet.write(i, 5, l.user.street_number)
        worksheet.write(i, 6, l.user.internal_number)
        worksheet.write(i, 7, l.user.outside_number)
        worksheet.write(i, 8, l.user.neighborhood)
        worksheet.write(i, 9, l.user.section)
        worksheet.write(i, 10, l.user.city)
        worksheet.write(i, 11, l.user.subenlace_id != 0 ? User.find(l.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, l.user.enlace_id != 0 ? User.find(l.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, l.user.coordinador_id != 0 ? User.find(l.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, l.user.get_group)
        worksheet.write(i, 15, l.user.role)
        worksheet.write(i, 16, l.check ? "Si" : "NO")
        i = i + 1
        @jugadores = @listvotation.where("users.subenlace_id = #{l.user.id} AND users.role = 'jugador'")
        @jugadores.each do |s|
          worksheet.write(i, 0, s.number)
          worksheet.write(i, 1, s.user.name)
          worksheet.write(i, 2, s.user.first_name)
          worksheet.write(i, 3, s.user.last_name)
          worksheet.write(i, 4, s.user.age)
          worksheet.write(i, 5, s.user.street_number)
          worksheet.write(i, 6, s.user.internal_number)
          worksheet.write(i, 7, s.user.outside_number)
          worksheet.write(i, 8, s.user.neighborhood)
          worksheet.write(i, 9, s.user.section)
          worksheet.write(i, 10, s.user.city)
          worksheet.write(i, 11, s.user.subenlace_id != 0 ? User.find(s.user.subenlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 12, s.user.enlace_id != 0 ? User.find(s.user.enlace_id).full_name : "Sin Asignar")
          worksheet.write(i, 13, s.user.coordinador_id != 0 ? User.find(s.user.coordinador_id).full_name : "Sin Asignar")
          worksheet.write(i, 14, s.user.get_group)
          worksheet.write(i, 15, s.user.role)
          worksheet.write(i, 16, s.check ? "Si" : "NO")
          i = i + 1
        end
      end
      @jugadores_nosub = @listvotation.where("users.enlace_id = #{params[:enlace]} AND users.subenlace_id = 0 AND users.role = 'jugador'")
      @jugadores_nosub.each do |s|
        worksheet.write(i, 0, s.number)
        worksheet.write(i, 1, s.user.name)
        worksheet.write(i, 2, s.user.first_name)
        worksheet.write(i, 3, s.user.last_name)
        worksheet.write(i, 4, s.user.age)
        worksheet.write(i, 5, s.user.street_number)
        worksheet.write(i, 6, s.user.internal_number)
        worksheet.write(i, 7, s.user.outside_number)
        worksheet.write(i, 8, s.user.neighborhood)
        worksheet.write(i, 9, s.user.section)
        worksheet.write(i, 10, s.user.city)
        worksheet.write(i, 11, s.user.subenlace_id != 0 ? User.find(s.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, s.user.enlace_id != 0 ? User.find(s.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, s.user.coordinador_id != 0 ? User.find(s.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, s.user.get_group)
        worksheet.write(i, 15, s.user.role)
        worksheet.write(i, 16, s.check ? "Si" : "NO")
        i = i + 1
      end
    end

    if order == 3
      @jugadores_sub = @listvotation.where("users.subenlace_id = #{params[:subenlace]} AND users.role = 'jugador'")
      @jugadores_sub.each do |s|
        worksheet.write(i, 0, s.number)
        worksheet.write(i, 1, s.user.name)
        worksheet.write(i, 2, s.user.first_name)
        worksheet.write(i, 3, s.user.last_name)
        worksheet.write(i, 4, s.user.age)
        worksheet.write(i, 5, s.user.street_number)
        worksheet.write(i, 6, s.user.internal_number)
        worksheet.write(i, 7, s.user.outside_number)
        worksheet.write(i, 8, s.user.neighborhood)
        worksheet.write(i, 9, s.user.section)
        worksheet.write(i, 10, s.user.city)
        worksheet.write(i, 11, s.user.subenlace_id != 0 ? User.find(s.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, s.user.enlace_id != 0 ? User.find(s.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, s.user.coordinador_id != 0 ? User.find(s.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, s.user.get_group)
        worksheet.write(i, 15, s.user.role)
        worksheet.write(i, 16, s.check ? "Si" : "NO")
        i = i + 1
      end
    end

    if order == 0
      @listvotation.each do |s|
        worksheet.write(i, 0, s.number)
        worksheet.write(i, 1, s.user.name)
        worksheet.write(i, 2, s.user.first_name)
        worksheet.write(i, 3, s.user.last_name)
        worksheet.write(i, 4, s.user.age)
        worksheet.write(i, 5, s.user.street_number)
        worksheet.write(i, 6, s.user.internal_number)
        worksheet.write(i, 7, s.user.outside_number)
        worksheet.write(i, 8, s.user.neighborhood)
        worksheet.write(i, 9, s.user.section)
        worksheet.write(i, 10, s.user.city)
        worksheet.write(i, 11, s.user.subenlace_id != 0 ? User.find(s.user.subenlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 12, s.user.enlace_id != 0 ? User.find(s.user.enlace_id).full_name : "Sin Asignar")
        worksheet.write(i, 13, s.user.coordinador_id != 0 ? User.find(s.user.coordinador_id).full_name : "Sin Asignar")
        worksheet.write(i, 14, s.user.get_group)
        worksheet.write(i, 15, s.user.role)
        worksheet.write(i, 16, s.check ? "Si" : "NO")
        i = i + 1
      end
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
