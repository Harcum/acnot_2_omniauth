class PeopleTermsController < ApplicationController
  before_action :set_people_term, only: [:show, :edit, :update, :destroy]

  # GET /people_terms
  # GET /people_terms.json
  def index
    @people_terms = PeopleTerm.where(["person_id = ?", params[:person_id]]).includes(:term).order("terms.start_date")
  end


  def transcript
    if(params.has_key?(:term_id)) 
      @people_terms_transcripts = PeopleTerm.where(["person_id = ? and term_id = ?", params[:person_id],params[:term_id]]).includes(:term).order("terms.start_date")
    else
      @people_terms_transcripts = PeopleTerm.where(["person_id = ?", params[:person_id]]).includes(:term).order("terms.start_date")      
    end
    render :layout => false
  end

  def bill
    @people_terms_bills = PeopleTerm.where(["person_id = ?", params[:person_id]]).includes(:term).order("terms.start_date")   
    render :layout => false
  end

  def hist_attendance
    if(params.has_key?(:term_id)) 
      @people_terms_hist_attendances = PeopleTerm.where(["person_id = ? and term_id = ?", params[:person_id],params[:term_id]]).includes(:term).order("terms.start_date")
    else
      @people_terms_hist_attendances = PeopleTerm.where(["person_id = ?", params[:person_id]]).includes(:term).order("terms.start_date")      
    end
    render :layout => false
  end

  # GET /people_terms/1
  # GET /people_terms/1.json
  def show
  end

  # GET /people_terms/new
  def new
    @people_term = PeopleTerm.new
  end

  # GET /people_terms/1/edit
  def edit
  end

  # POST /people_terms
  # POST /people_terms.json
  def create
    @people_term = PeopleTerm.new(people_term_params)

    respond_to do |format|
      if @people_term.save
        format.html { redirect_to @people_term, notice: 'People term was successfully created.' }
        format.json { render :show, status: :created, location: @people_term }
      else
        format.html { render :new }
        format.json { render json: @people_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people_terms/1
  # PATCH/PUT /people_terms/1.json
  def update
    respond_to do |format|
      if @people_term.update(people_term_params)
        format.html { redirect_to @people_term, notice: 'People term was successfully updated.' }
        format.json { render :show, status: :ok, location: @people_term }
      else
        format.html { render :edit }
        format.json { render json: @people_term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people_terms/1
  # DELETE /people_terms/1.json
  def destroy
    @people_term.destroy
    respond_to do |format|
      format.html { redirect_to people_terms_url, notice: 'People term was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_people_term
      @people_term = PeopleTerm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def people_term_params
      params.require(:people_term).permit(:person_id, :term_id)
    end
end
