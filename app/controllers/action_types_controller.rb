class ActionTypesController < ApplicationController
  before_action :set_action_type, only: [:show, :edit, :update, :destroy]

  # GET /action_types
  # GET /action_types.json
  def index
    # @action_types = ActionType.where(["id in (?)", params[:action_ids]])
   # @action_types = ActionType.where("id in (#{params[:action_ids]})")
   @action_types = ActionType.all

  end
  
def email_string
    @action_types_email_string = ActionType.where("id in (#{params[:ids]})")
    render :layout => false
 end

  # GET /action_types/1
  # GET /action_types/1.json
  def show
  end

  # GET /action_types/new
  def new
    @action_type = ActionType.new
  end

  # GET /action_types/1/edit
  def edit
  end

  # POST /action_types
  # POST /action_types.json
  def create
    @action_type = ActionType.new(action_type_params)

    respond_to do |format|
      if @action_type.save
        format.html { redirect_to @action_type, notice: 'Action type was successfully created.' }
        format.json { render :show, status: :created, location: @action_type }
      else
        format.html { render :new }
        format.json { render json: @action_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /action_types/1
  # PATCH/PUT /action_types/1.json
  def update
    respond_to do |format|
      if @action_type.update(action_type_params)
        format.html { redirect_to @action_type, notice: 'Action type was successfully updated.' }
        format.json { render :show, status: :ok, location: @action_type }
      else
        format.html { render :edit }
        format.json { render json: @action_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action_types/1
  # DELETE /action_types/1.json
  def destroy
    @action_type.destroy
    respond_to do |format|
      format.html { redirect_to action_types_url, notice: 'Action type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_action_type
      @action_type = ActionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def action_type_params
      params.require(:action_type).permit!
      #permit(:id, :code, :description, :role_id, :email_text, :email_completed_text, :days_til_due)
    end
end
