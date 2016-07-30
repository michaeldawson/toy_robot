require 'spec_helper'

RSpec.describe 'Robot knows how to handle itself on a table' do
  context do
    COMMANDS = {
      'PLACE 0,0,NORTH
      MOVE
      REPORT' => "X: 0, Y: 1, F: NORTH\n",

      'PLACE 0,0,NORTH
      LEFT
      REPORT' => "X: 0, Y: 0, F: WEST\n",

      'PLACE 1,2,EAST
      MOVE
      MOVE
      LEFT
      MOVE
      REPORT' => "X: 3, Y: 3, F: NORTH\n"
    }

    COMMANDS.each do |command_set, report_expectation|
      pending 'works' do
        expect {
          CommandParser.perform(command_set)
        }.to output(report_expectation).to_stdout
      end
    end
  end
end
