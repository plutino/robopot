class PotDataController < ApplicationController
  # GET /pot_data
  # GET /pot_data.json
  def index
  end

  def get_level
    render json: {level: PotDatum.last.level}
  end

  def get_potdata
    @duration = (params[:duration] || '3600').to_i
    interval = (@duration / 400).to_i
    start_time = Time.now - @duration
    @data = PotDatum.where('created_at > ?', start_time).where('id % ? = 0', interval)
    data_a = [['Time', 'Level']] + @data.map{|d| [d.created_at, d.level]}
    render json: {data_array: data_a  }
  end

end
