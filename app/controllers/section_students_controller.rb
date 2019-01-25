class SectionStudentsController < ApplicationController
  before_action :set_section_student, only: [:show, :edit, :update, :destroy]

  # GET /section_students
  # GET /section_students.json
  def index
    #@section_students = SectionStudent.all
    #@section_students = SectionStudent.where("student_id = ?", params[:student_id])
    @section_students = SectionStudent.find_by_sql ["select * from ss_view (?,?)", params[:student_id], params[:created_by]]
    render :layout => false
  end

  # GET /section_students/1
  # GET /section_students/1.json
  def show
  end

  # GET /section_students/new
  def new
    @section_student = SectionStudent.new
  end

  # GET /section_students/1/edit
  def edit
  end

  # POST /section_students
  # POST /section_students.json
  def create
    @section_student = SectionStudent.new(section_student_params)

    respond_to do |format|
      if @section_student.save
        format.html { redirect_to @section_student, notice: 'Section student was successfully created.' }
        format.json { render :show, status: :created, location: @section_student }
      else
        format.html { render :new }
        format.json { render json: @section_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_students/1
  # PATCH/PUT /section_students/1.json
  def update
    respond_to do |format|
      if @section_student.update(section_student_params)
        format.html { redirect_to @section_student, notice: 'Section student was successfully updated.' }
        format.json { render :show, status: :ok, location: @section_student }
      else
        format.html { render :edit }
        format.json { render json: @section_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_students/1
  # DELETE /section_students/1.json
  def destroy
    @section_student.destroy
    respond_to do |format|
      format.html { redirect_to section_students_url, notice: 'Section student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_student
      @section_student = SectionStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_student_params
      params.require(:section_student).permit(:id, :student_id, :instructor_id, :advisor_id, :start_date, :end_date, :session, :section, :curriculum, :present, :absent)
    end
end
