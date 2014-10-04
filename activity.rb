require_relative 'lap'

class Activity
  attr_accessor :laps, :sport, :id

  def initialize
    @laps = []
  end

  def ==(other)
    id == other.id
  end

  def start_time
    laps.first.start_time
  end

  def distance_meters
    laps.reduce(0) { |sum, l| sum + l.distance_meters }
  end

  def maximum_speed
    laps.reduce(0) { |max, l| [max, l.maximum_speed].max }
  end

  def total_time_seconds
    laps.reduce(0) { |sum, l| sum + l.total_time_seconds }
  end

  def calories
    laps.reduce(0) { |sum, l| sum + l.calories }
  end

  def <<(lap)
    laps << lap
  end

  # in kilometers per hour
  def average_speed
    (distance_meters.to_f / 1000) / (total_time_seconds / 60 / 60)
  end

  # in minutes per kilometer
  def average_pace
    (total_time_seconds.to_f / 60) / (distance_meters / 1000)
  end
end