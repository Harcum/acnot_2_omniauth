class PeopleController < ApplicationController
  
  #self.page_cache_directory = -> { Rails.root.join("public", request.domain) }
  #caches_page :search_pc_index, :search_index, :index_all
  
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_filter :set_thumbs

  def set_thumbs
    @all_people = Person.all
  end
  

  def show_thumb
      #@person = Person.find(params[:id])
      @person = @all_people.find(params[:id])
      send_data @person.photo_thumb, :type => 'image/jpg',:disposition => 'inline'
  end
  
  def show_image
      @person = Person.find(params[:id])
      send_data @person.photo, :type => 'image/jpg',:disposition => 'inline'
  end
  
  # GET /people
  # GET /people.json
  def index
    @current_user_id = Person.where(email: current_user.email).take.id
    #@people = Person.find_by_sql ["select * from my_students_view (?,'')", @current_user_id]
    @people = Person.all
  end
  

  
  
  def users
    @people = Person.find_by_sql ["select * from people where email in (select email from users)"]
  end

  def my_profile
    @my_profile = Person.where(email: current_user.email).take
  end
  
  def profile_admin
    @profile_admin = Person.where(id: params[:id]).take
  end

  def all_index
    @people = Person.all.order(:last_name,:first_name)
    render :layout => false
  end


  def search_index
    if !params[:search]
      @search = '' 
    else
      @search = params[:search]
    end
    if !params[:former]
      @former = 0    
    else
      @former = params[:former]    
    end  
    
    @people = Person.find_by_sql ["select * from my_students_view (?,'') where first_name +' '+ last_name LIKE ? and former_student = ? and is_student = 1",params[:created_by], "%#{@search}%", @former]
    render :layout => false
  end

  def search_pc_index
    @people = Person.find_by_sql ["select *,null,null,null,null from vw_people_all where first_name +' '+ last_name LIKE ?", "%#{params[:search]}%"]
    render :layout => false
  end

  def action_assignees   
    @action_assignees = Person.find_by_sql ["select id,first_name,last_name,username,email,photo,photo_thumb,default_cc,lock_cc from action_assignees_selector (?,?,?) order by [default] desc", params[:action_id],params[:student_id],params[:section_student_id]]
    render :layout => false
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    new_id = ActiveRecord::Base.connection.exec_query("select max(id) + 1 from people where id >= 2000000").rows[0][0]
    puts 'got new id: ' + new_id.to_s
    
    @person.id = new_id
    
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit! #(:id, :first_name, :last_name, :username, :email)
    end
end
