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

first = 1.year.ago
last = DateTime.now
bin_size = :week

binned_activities = Hash.new {|h, k| h[k] = ActivityAggregate.new }
activities.each do |a|
  next if a.start_time < first
  break if a.start_time > last
  bin = a.start_time.beginning_of_week
  binned_activities[bin] << a
end

g = Gruff::Bar.new
g.title = 'Running chart'

label_hash = Hash.new
# TODO(panmari): Possibly rotate/leave out certain labels
binned_activities.keys.each_with_index { |k, i| label_hash[i] = k.strftime('%m/%d')}

g.labels = label_hash
# TODO(panmari): Allow other measures than distance_meters summed up
g.data :running, binned_activities.values.map(&:distance_meters)

g.write('running_chart.png')