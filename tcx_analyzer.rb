require_relative 'tcx_parser'
require 'active_support/all'


tcx_path = '/home/mazzzy/Dropbox/Apps/tapiriik/'
tcx_files = Dir.glob(tcx_path + '*.tcx')

activities = []
tcx_files.each { |i| activities += TcxParser.parse(i) }
activities.sort_by! &:start_time

first = 1.month.ago
last = DateTime.now

activities.each do |a|
  next if a.start_time < first
  puts a
end