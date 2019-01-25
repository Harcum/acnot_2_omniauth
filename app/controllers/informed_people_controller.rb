class InformedPeopleController < ApplicationController
  before_action :set_informed_person, only: [:show, :edit, :update, :destroy]

  # GET /informed_people
  # GET /informed_people.json
  def index
    @informed_people = InformedPerson.all
  end

  # GET /informed_people/1
  # GET /informed_people/1.json
  def show
  end

  # GET /informed_people/new
  def new
    @informed_person = InformedPerson.new
  end

  # GET /informed_people/1/edit
  def edit
  end

  # POST /informed_people
  # POST /informed_people.json
  def create
    @informed_person = InformedPerson.new(informed_person_params)

    respond_to do |format|
      if @informed_person.save
        format.html { redirect_to @informed_person, notice: 'Informed person was successfully created.' }
        format.json { render :show, status: :created, location: @informed_person }
      else
        format.html { render :new }
        format.json { render json: @informed_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /informed_people/1
  # PATCH/PUT /informed_people/1.json
  def update
    respond_to do |format|
      if @informed_person.update(informed_person_params)
        format.html { redirect_to @informed_person, notice: 'Informed person was successfully updated.' }
        format.json { render :show, status: :ok, location: @informed_person }
      else
        format.html { render :edit }
        format.json { render json: @informed_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /informed_people/1
  # DELETE /informed_people/1.json
  def destroy
    @informed_person.destroy
    respond_to do |format|
      format.html { redirect_to informed_people_url, notice: 'Informed person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_informed_person
      @informed_person = InformedPerson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def informed_person_params
      params.require(:informed_person).permit(:person_id, :student_id)
    end
end
