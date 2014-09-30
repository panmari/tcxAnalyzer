require 'nokogiri'
require_relative 'activity'

class TcxParser

  def self.parse(filename)
    xml=Nokogiri::XML File.open filename
    xml.remove_namespaces!
    activities = []
    xml.xpath("//Activity").each do |activity|
      a = Activity.new
      a.sport = activity['Sport']
      activity.xpath('Lap').each do |lap|
        l = Lap.new
        l.id = activity.xpath('Id').children
        l.start_time = DateTime.parse(lap['StartTime'])
        l.total_time_seconds = lap.xpath('TotalTimeSeconds').first.content.to_f
        l.distance_meters = lap.xpath('DistanceMeters').first.content.to_f
        l.maximum_speed = lap.xpath('MaximumSpeed').first.content.to_f
        l.calories = lap.xpath('Calories').first.content.to_i
        a.laps << l
      end
      activities << a
    end
    return activities
  end
end