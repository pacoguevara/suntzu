class MilitantsController < ApplicationController
  load_and_authorize_resource
  before_action :set_militant, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]  
  # GET /militants
  # GET /militants.json
  def index
    @militants = User.all
    @canedit = true
  end
  def links
  end
  def sublinks
  end
  def coordinators
  end
  # GET /militants/1
  # GET /militants/1.json
  def show
    puts "show"
  end

  # GET /militants/new
  def new
    @militant = User.new
  end

  # GET /militants/1/edit
  def edit
  end

  # POST /militants
  # POST /militants.json
  def create
    @militant = User.new(militant_params)

    respond_to do |format|
      if @militant.save
        format.html { redirect_to @militant, notice: 'Militant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @militant }
      else
        format.html { render action: 'new' }
        format.json { render json: @militant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /militants/1
  # PATCH/PUT /militants/1.json
  def update
    respond_to do |format|
      if @militant.update(militant_params)
        format.html { redirect_to @militant, notice: 'Militant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @militant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /militants/1
  # DELETE /militants/1.json
  def destroy
    @militant.destroy
    respond_to do |format|
      format.html { redirect_to militants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_militant
      @militant = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def militant_params
      params.require(:user).permit(:register_date, :first_name, :last_name, :name, :bird, :rnm, :linking, :sub_linking, :group_id, :suburb, :section, :sector, :cp, :phone, :cellphone, :email)
    end
end
