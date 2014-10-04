require_relative 'tcx_parser'
require_relative 'activity_aggregate'
require 'active_support/all'
require 'gruff'

tcx_path = '/home/mazzzy/Dropbox/Apps/tapiriik/'
tcx_files = Dir.glob(tcx_path + '*.tcx')

activities = []
tcx_files.each { |i| activities += TcxParser.parse(i) }

activities.uniq! { |a| a.id }
activities.sort_by! &:start_time

first = 2.year.ago
last = DateTime.now
bin_size = :week

binned_activities = Hash.new {|h, k| h[k] = ActivityAggregate.new }
activities.each do |a|
  next if a.start_time < first
  next if a.sport != 'Running'
  next if a.distance_meters == 0
  break if a.start_time > last
  bin = a.start_time.beginning_of_week
  binned_activities[bin] << a
end

g = Gruff::Bar.new('1000x600')
g.title = 'Kilometers per week'
g.hide_legend = true

label_hash = Hash.new
binned_activities.keys.each_with_index { |k, i| label_hash[i] = k.strftime('%d.%m.%y')}
# Reduce the number of labels
number_labels = 6
m = binned_activities.count/number_labels
label_hash.select! { |k, _| k % m == 0}
g.labels = label_hash
# TODO(panmari): Allow other measures than distance_meters summed up
g.data :running, binned_activities.values.map(&:average_speed)

g.write('running_chart.png')