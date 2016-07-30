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

  describe '#move' do
    context 'when the move is valid' do
      it 'moves the robot appropriately when facing NORTH' do
        robot.place(2, 2, 'NORTH')

        expect {
          robot.move
        }.to change {
          [robot.x, robot.y]
        }.from([2, 2]).to([2, 3])
      end

      it 'moves the robot appropriately when facing SOUTH' do
        robot.place(2, 2, 'SOUTH')

        expect {
          robot.move
        }.to change {
          [robot.x, robot.y]
        }.from([2, 2]).to([2, 1])
      end

      it 'moves the robot appropriately when facing EAST' do
        robot.place(2, 2, 'EAST')

        expect {
          robot.move
        }.to change {
          [robot.x, robot.y]
        }.from([2, 2]).to([3, 2])
      end

      it 'moves the robot appropriately when facing WEST' do
        robot.place(2, 2, 'WEST')

        expect {
          robot.move
        }.to change {
          [robot.x, robot.y]
        }.from([2, 2]).to([1, 2])
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
