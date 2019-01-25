class StudentAttributesController < ApplicationController
  before_action :set_student_attribute, only: [:show, :edit, :update, :destroy]

  # GET /student_attributes
  # GET /student_attributes.json
  def index
    @student_attributes = StudentAttribute.all
  end

  # GET /student_attributes/1
  # GET /student_attributes/1.json
  def show
    render :layout => false
  end

  # GET /student_attributes/new
  def new
    @student_attribute = StudentAttribute.new
  end

  # GET /student_attributes/1/edit
  def edit
  end

  # POST /student_attributes
  # POST /student_attributes.json
  def create
    @student_attribute = StudentAttribute.new(student_attribute_params)

    respond_to do |format|
      if @student_attribute.save
        format.html { redirect_to @student_attribute, notice: 'Student attribute was successfully created.' }
        format.json { render :show, status: :created, location: @student_attribute }
      else
        format.html { render :new }
        format.json { render json: @student_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_attributes/1
  # PATCH/PUT /student_attributes/1.json
  def update
    respond_to do |format|
      if @student_attribute.update(student_attribute_params)
        format.html { redirect_to @student_attribute, notice: 'Student attribute was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_attribute }
      else
        format.html { render :edit }
        format.json { render json: @student_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_attributes/1
  # DELETE /student_attributes/1.json
  def destroy
    @student_attribute.destroy
    respond_to do |format|
      format.html { redirect_to student_attributes_url, notice: 'Student attribute was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_attribute
      @student_attribute = StudentAttribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_attribute_params
      params.require(:student_attribute).permit(:id, :birth_date, :curriculum, :address_line_1, :address_line_2, :city, :state, :zip_code, :matric_date, :resident_commuter, :emergency_contact_name, :emergency_contact_number, :emergency_contact_relationship, :advisor, :personal_email, :harcum_email, :phone_numbers)
    end
end
