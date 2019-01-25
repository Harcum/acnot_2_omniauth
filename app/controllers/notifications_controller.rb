class NotificationsController < ApplicationController
  def index
    @grid = NotificationsGrid.new(params[:notifications_grid]) do |scope|
      scope.page(params[:page])
    end
  end
  before_action :set_notification, only: [:show, :edit, :update, :destroy]
  before_action :set_show_financials, only: [:show, :edit, :update, :destroy, :new]

  # this sets     @my_reasons and @my_action_types which are used in collection selects
  before_action :set_select_collections, only: [:edit, :update, :new, :create, :show]
  #before_action :set_student_info, only: [:edit,  :show]


  # GET /notifications
  # GET /notifications.json
  def index_no_grid
    # moved below to application controller
    #@current_user_id = Person.where(email: current_user.email).take.id
    #@is_admin = Person.where(email: current_user.email).take.roles.where(code: "Admin").count == 1
    # @notifications = Notification.where(created_by: @current_user_id).all
    @notifications = Person.where(email: current_user.email).take.notifications.all
  end
  
  
  def summary_by_student
    @notifications = Notification.where(person_id: params[:person_id]).all
    render :layout => false
  end
  
  def index  
    if Person.where(email: current_user.email).take
      @current_user_id = Person.where(email: current_user.email).take.id
      @is_admin = Person.where(email: current_user.email).take.roles.where(code: "Admin").count == 1
      @grid = NotificationsGrid.new(params[:notifications_grid]) do |scope|
        scope.where(["[notification_viewers].person_id = ?",@current_user_id])
      end
    end
  end
  
 
  
  
  # GET /notifications/1
  # GET /notifications/1.json
  def show
        @current_user_id = Person.where(email: current_user.email).take.id
  end

  # GET /notifications/new
  def new
    @current_user_id = Person.where(email: current_user.email).take.id
    puts('setting current user id to: ' + @current_user_id.to_s)    
    @notification = Notification.new
    @notification.emails.build
    @notification.notification_reasons.build
    @notification.notification_actions.build
    

    
  end

  # GET /notifications/1/edit
  def edit
    # notifications is created to render the partial summary_by_student
    @current_user_id = Person.where(email: current_user.email).take.id
  
  #puts "got param action = " + params[:subaction]
  if params[:subaction] == "take"    
    puts "entering TAKE"  
    @notification.notification_actions.all.each do |action|
      if action.action_status_id == 1 && action.assigned_to > 1000000  && action.assigned_to < 2000000# only look at open  and assigned to a pool
        # get people in assignment pool
        puts "looking at action " + action.action_type.code
        @action_assignees_array = Person.find_by_sql ["select * from action_assignees_selector (?,?,?)", action.action_type_id,@notification.person_id,@notification.section_student_id]
        @action_assignees = Person.where(id: @action_assignees_array.map(&:id))
        # if I am in pool, assign to me
        if @action_assignees.exists?(@current_user_id)
          action.assigned_to = @current_user_id 
          puts "action " + action.action_type.code + " now assigned to: " + action.assignee.full_name
          action.save
          action.reload   
        end
      end
    end # close each
    
    
    @notification.save
    @notification.reload
    end    
  end

  # POST /notifications
  # POST /notifications.json
  def create
    #@my_reasons = Person.where(email: current_user.email).take.role_viewable_reasons.all()
    #@my_action_types = Person.where(email: current_user.email).take.role_viewable_action.all()
    
    # remove empty action
    if !notification_params['notification_actions_attributes']['0']['assigned_to']
      puts 'removing empty action'
      notification_params.delete('notification_actions_attributes')
    end   
   
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to notifications_url }
        #format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        #format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to notifications_url }
        #format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        #format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
      @student_attribute = @notification.student_attribute 
      @people_terms_transcripts = PeopleTerm.where(["person_id = ?", @notification.person_id])
      @people_terms_bills = @people_terms_transcripts
      @people_terms_hist_attendances = PeopleTerm.where(["person_id = ?", @notification.person_id])
          @notifications = Notification.where(person_id: @notification.person_id).all
   
    @aids = Aid.where(person_id: @notification.person_id).all
    end
    
    
    # this has to have its own callback so it gets run before new
    def set_show_financials
      @show_financials = Person.where(email: current_user.email).take.roles.where(show_financials: 1).count == 1
    end
    
    def set_select_collections
      @my_reasons = Person.where(email: current_user.email).take.selectable_reasons.all().distinct
      @my_action_types = Person.where(email: current_user.email).take.selectable_actions.all().distinct
       
      # these are used to populate the autocompletes 
      @my_students_array = Person.find_by_sql ["select * from my_students_view (?,'') where former_student = 0",@current_user_id]
      @my_students = Person.where(id: @my_students_array.map(&:id))
      
      @my_former_students_array = Person.find_by_sql ["select * from my_students_view (?,'') where former_student = 1",@current_user_id]
      @my_former_students = Person.where(id: @my_former_students_array.map(&:id))
      
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit!
      #(:id, :section_student_id, :created_at, :created_by, :modified_at, :modified_by, :status_id)
    end
end
