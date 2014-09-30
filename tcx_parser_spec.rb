require 'rspec'
require_relative 'tcx_parser'

describe 'Txc parser should be able to parse a simple file with only one lap' do

  it 'should do something' do
    activities = TcxParser.parse('2012-08-23_Running.tcx')
    expect(activities.length).to be 1
    activity = activities.first
    expect(activity.sport).to eq 'Running'
    expect(activity.start_time).to eq activity.laps.first.start_time
    expect(activity.distance_meters). to eq 8400.444984436035
    expect(activity.maximum_speed). to eq 5.397222222222222
    expect(activity.calories).to eq 596
  end
end