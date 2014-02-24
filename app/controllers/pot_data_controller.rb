class PotDataController < ApplicationController
  # GET /pot_data
  # GET /pot_data.json
  def index
  end

  def get_level
    level = PotDatum.last.level / 5
    #level = 10.0 if level > 10.0
    #level = 0.0 if level < 0.0
    render json: {level: level}
  end

  def get_potdata
    if params[:duration].nil?
      Thread.current[:duration] ||= 3600
    else
      Thread.current[:duration] = params[:duration].to_i
    end
    duration = Thread.current[:duration]
    interval = (duration / 500).to_i
    start_time = Time.now - duration
    puts duration, interval, start_time

    @data = PotDatum.where('created_at > ?', start_time).where('id % ? = 0', interval)
    data_a = [['Time', 'Level']] + @data.map{|d| [d.created_at, d.level]}
    render json: {data_array: data_a, duration: duration  }
  end

end
