class PotDatum < ActiveRecord::Base
  attr_accessible :level

  before_save :scale_level

  private

  def scale_level
    #raw = self.level
    #self.level = (raw - 150)
  end

end
