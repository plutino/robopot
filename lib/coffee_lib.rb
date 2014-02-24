require 'serialport'

class CoffeeLib

  class << self
    attr_accessor :instance

    def instance
      @instance ||= new
    end
  end

  def on_value(&block)
    @callback = block
  end
  
  def get_last_val
    @semaphore.synchronize do
      @last_val
    end
  end
  
  def get_last_filtered
    @semaphore.synchronize do
      last_filtered
    end
  end
  
protected
  
  def last_filtered
    return nil if @last_three.size != 3
    @last_three.sort[1]
  end

  
  def process_val(val)
    @semaphore.synchronize do
      @last_val = val
      @last_three << @last_val
      @last_three.shift until @last_three.size <= 3
      process_event
    end
  end
  
  def process_event
    val = last_filtered
    if val && @callback
      @callback.call(val)
      puts "Data inserted #{val.to_s}"
    end
  end
  
  def main_loop
    while true
     process_val(read_val)
    end
  end
  
  
  def read_val
    tmp = []
    next_char = nil
    while !next_char || next_char.ord != 10
      next_char = read_char
      tmp << next_char
    end
    sensor_str = tmp.join
    
    if sensor_str =~ /sensor = ([0-9]+)/
      $1.to_i
    else
      nil
    end
    
  end
  
  def read_char
    @port.read(1)
  end

  private

  def initialize
    Dir.glob("/dev/tty.usbserial*").each do |tty_path|
      @port = SerialPort.new(tty_path, {"parity"=>0, "stop_bits"=>1, "baud"=>57600, "data_bits"=>8})
    end
    @semaphore = Mutex.new
    @thread = Thread.new {main_loop}
    @last_three = []
  end

end