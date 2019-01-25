class CcViewsController < ApplicationController
  before_action :set_cc_view, only: [:show, :edit, :update, :destroy]

  # GET /cc_views
  # GET /cc_views.json
  def index
    #@cc_views = CcView.all
     
    @cc_views = CcView.find_by_sql ["select * from cc_view (?,?,?,?,?,?)", params[:creator_id],params[:student_id],params[:section_student_id],params[:action_assignee_ids],params[:action_ids],params[:reason_ids]]
    render :layout => false
    #"select * from cc_view (1402,69118,333017,'58378,43405','2,1003','4,5')"
    
  end

  # GET /cc_views/1
  # GET /cc_views/1.json
  def show
  end

  # GET /cc_views/new
  def new
    @cc_view = CcView.new
  end

  # GET /cc_views/1/edit
  def edit
  end

  # POST /cc_views
  # POST /cc_views.json
  def create
    @cc_view = CcView.new(cc_view_params)

    respond_to do |format|
      if @cc_view.save
        format.html { redirect_to @cc_view, notice: 'Cc view was successfully created.' }
        format.json { render :show, status: :created, location: @cc_view }
      else
        format.html { render :new }
        format.json { render json: @cc_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cc_views/1
  # PATCH/PUT /cc_views/1.json
  def update
    respond_to do |format|
      if @cc_view.update(cc_view_params)
        format.html { redirect_to @cc_view, notice: 'Cc view was successfully updated.' }
        format.json { render :show, status: :ok, location: @cc_view }
      else
        format.html { render :edit }
        format.json { render json: @cc_view.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cc_views/1
  # DELETE /cc_views/1.json
  def destroy
    @cc_view.destroy
    respond_to do |format|
      format.html { redirect_to cc_views_url, notice: 'Cc view was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cc_view
      @cc_view = CcView.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cc_view_params
      params.require(:cc_view).permit(:id, :display, :default, :locked)
    end
end
