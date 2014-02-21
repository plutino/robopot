class PotDataController < ApplicationController
  # GET /pot_data
  # GET /pot_data.json
  def index
    @pot_data = PotDatum.all
    @data = load_data
  end

  def get_level
    render json: {level: PotDatum.last.level}
  end

  # GET /pot_data/1
  # GET /pot_data/1.json
  def show
    @pot_datum = PotDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pot_datum }
    end
  end

  # GET /pot_data/new
  # GET /pot_data/new.json
  def new
    @pot_datum = PotDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pot_datum }
    end
  end

  # GET /pot_data/1/edit
  def edit
    @pot_datum = PotDatum.find(params[:id])
  end

  # POST /pot_data
  # POST /pot_data.json
  def create
    @pot_datum = PotDatum.new(params[:pot_datum])

    respond_to do |format|
      if @pot_datum.save
        format.html { redirect_to @pot_datum, notice: 'Pot datum was successfully created.' }
        format.json { render json: @pot_datum, status: :created, location: @pot_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @pot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pot_data/1
  # PUT /pot_data/1.json
  def update
    @pot_datum = PotDatum.find(params[:id])

    respond_to do |format|
      if @pot_datum.update_attributes(params[:pot_datum])
        format.html { redirect_to @pot_datum, notice: 'Pot datum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pot_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pot_data/1
  # DELETE /pot_data/1.json
  def destroy
    @pot_datum = PotDatum.find(params[:id])
    @pot_datum.destroy

    respond_to do |format|
      format.html { redirect_to pot_data_url }
      format.json { head :no_content }
    end
  end


  private

  def load_data
    PotDatum.all.inject({}) do |h, d|
      h.merge(d.created_at => d.level)
    end
  end

end
