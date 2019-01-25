class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_filter :get_users
  
  
    before_action :check_admin
    def check_admin
      if ! @is_admin
        redirect_to '/denied.html'
      end      
    end
  

  def get_users
    #@role_users = Person.find_by_sql ["select * from people where email in (select email from users)"]
  end
  
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role_users_array = Person.find_by_sql ["select * from people where email in (select email from users)"]
    @role_users = Person.where(id: @role_users_array.map(&:id))
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role_users_array = Person.find_by_sql ["select * from people where email in (select email from users)"]
    @role_users = Person.where(id: @role_users_array.map(&:id))
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)
    @role.save
    
    if @role.has_pool
      
      @role.default_assignee_id = 1000000 + @role.id   
      @person = Person.new
      @person.id = 1000000 + @role.id
    
      if @role.pool_display_name.length() > 0
        @person.first_name = @role.pool_display_name
      else
        @person.first_name = @role.code + " Pool"
      end
      @person.last_name = ""
      @person.save
    
      @people_role = PeopleRole.new
      @people_role.role_id = @role.id
      @people_role.person_id = 1000000 + @role.id
      @people_role.save
    end
    
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    
    # this dirty check does not work
    
    #if @role.pool_display_name != params[:role][:pool_display_name]
    #    @person = Person.find(1000000 + params[:id].to_i)
    #    @person.first_name = @role.pool_display_name
    #    @person.save
    #end
    
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit!
      #(:id, :code, :description, :use_ss)
    end
end
