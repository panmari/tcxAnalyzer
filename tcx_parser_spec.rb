require 'rspec'
require_relative 'tcx_parser'

describe 'Txc parser should be able to parse a simple file' do

  it 'should do something' do
    activities = TcxParser.parse('2012-08-23_Running.tcx')
    expect(activities.length).to be 1
    activity = activities.first
    expect(activity.sport).to eq 'Running'
    puts activities
  end
end