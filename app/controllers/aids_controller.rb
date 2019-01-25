class AidsController < ApplicationController
  before_action :set_aid, only: [:show, :edit, :update, :destroy]

  # GET /aids
  # GET /aids.json
  def index
    @aids = Aid.where(person_id: params[:person_id]).all
    render :layout => false
  end

  # GET /aids/1
  # GET /aids/1.json
  def show
  end

  # GET /aids/new
  def new
    @aid = Aid.new
  end

  # GET /aids/1/edit
  def edit
  end

  # POST /aids
  # POST /aids.json
  def create
    @aid = Aid.new(aid_params)

    respond_to do |format|
      if @aid.save
        format.html { redirect_to @aid, notice: 'Aid was successfully created.' }
        format.json { render :show, status: :created, location: @aid }
      else
        format.html { render :new }
        format.json { render json: @aid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aids/1
  # PATCH/PUT /aids/1.json
  def update
    respond_to do |format|
      if @aid.update(aid_params)
        format.html { redirect_to @aid, notice: 'Aid was successfully updated.' }
        format.json { render :show, status: :ok, location: @aid }
      else
        format.html { render :edit }
        format.json { render json: @aid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aids/1
  # DELETE /aids/1.json
  def destroy
    @aid.destroy
    respond_to do |format|
      format.html { redirect_to aids_url, notice: 'Aid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aid
      @aid = Aid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aid_params
      params.require(:aid).permit(:package_name, :person_id, :amount, :year)
    end
end
