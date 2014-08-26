class CandidateVotationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_candidate_votation, only: [:show, :edit, :update, :destroy]

  # GET /candidate_votations
  # GET /candidate_votations.json
  def index
    @candidate_votations = CandidateVotation.all
  end

  # GET /candidate_votations/1
  # GET /candidate_votations/1.json
  def show
  end

  # GET /candidate_votations/new
  def new
    @candidate_votation = CandidateVotation.new
  end

  # GET /candidate_votations/1/edit
  def edit
  end

  # POST /candidate_votations
  # POST /candidate_votations.json
  def create
    @candidate_votation = CandidateVotation.new(candidate_votation_params)

    respond_to do |format|
      if @candidate_votation.save
        format.html { redirect_to @candidate_votation, notice: 'Candidate votation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @candidate_votation }
      else
        format.html { render action: 'new' }
        format.json { render json: @candidate_votation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidate_votations/1
  # PATCH/PUT /candidate_votations/1.json
  def update
    respond_to do |format|
      if @candidate_votation.update(candidate_votation_params)
        format.html { redirect_to @candidate_votation, notice: 'Candidate votation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @candidate_votation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidate_votations/1
  # DELETE /candidate_votations/1.json
  def destroy
    @candidate_votation.destroy
    respond_to do |format|
      format.html { redirect_to candidate_votations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate_votation
      @candidate_votation = CandidateVotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_votation_params
      params.require(:candidate_votation).permit(:polling_id, :candidate_id)
    end
end
