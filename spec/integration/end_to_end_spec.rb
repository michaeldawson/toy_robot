require 'spec_helper'

RSpec.describe 'Robot knows how to handle itself on a table' do
  context do
    COMMANDS = {
      'PLACE 0,0,NORTH
      MOVE
      REPORT' => "0,1,NORTH\n",

      'PLACE 0,0,NORTH
      LEFT
      REPORT' => "0,0,WEST\n",

      'PLACE 1,2,EAST
      MOVE
      MOVE
      LEFT
      MOVE
      REPORT' => "3,3,NORTH\n",

      'PLACE 0,0,SOUTH
      MOVE
      MOVE
      LEFT
      LEFT
      REPORT' => "0,0,NORTH\n"
    }

    COMMANDS.each do |command_set, report_expectation|
      it 'works' do
        expect {
          CommandParser.perform(command_set)
        }.to output(report_expectation).to_stdout
      end
    end
  end
end
