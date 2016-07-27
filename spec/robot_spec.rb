require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    context 'with valid co-ordinates and direction' do
      it 'places the robot' do
        robot.place(0, 2, 'NORTH')

        expect(robot.x).to eq(0)
        expect(robot.y).to eq(2)
      end
    end

    context 'with invalid co-ordinates' do
      it "raises an error" do
        expect {
          robot.place(1, 6, 'NORTH')
        }.to raise_error('Invalid position: X: 1, Y: 6, F: NORTH')
      end
    end

    context 'with an invalid direction' do
      it "raises an error" do
        expect {
          robot.place(1, 2, 'FOOBAR')
        }.to raise_error('Invalid position: X: 1, Y: 2, F: FOOBAR')
      end
    end
  end

  describe '#report' do
    context 'when the robot has been placed' do
      it 'prints out the position of the robot' do
        robot.place(1, 2, 'NORTH')

        expect {
          robot.report
        }.to output("X: 1, Y: 2, F: NORTH\n").to_stdout
      end
    end
  end
end
