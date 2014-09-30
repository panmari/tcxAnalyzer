require_relative 'lap'

class Activity
  attr_accessor :laps, :sport

  def initialize
    @laps = []
  end

  def to_s
    "#{sport} " + laps.to_s
  end
end