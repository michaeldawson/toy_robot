require 'spec_helper'

RSpec.describe CommandParser do
  let(:command_parser) { CommandParser.new(input) }
  let(:robot) { double(:robot) }

  before :each do
    allow(Robot).to receive(:new).and_return(robot)
  end

  describe '#perform' do
    context 'with valid commands separated by newlines' do
      let(:input) {
        'PLACE 0,0,NORTH
        MOVE
        REPORT'
      }

      it 'dispatches commands' do
        expect(robot).to receive(:place).with(0, 0, 'NORTH')
        expect(robot).to receive(:move)
        expect(robot).to receive(:report)
        command_parser.perform
      end
    end

    context 'with valid commands separated by newlines, with some extra spacing' do
      let(:input) {
        'PLACE 0, 0, NORTH'
      }

      it 'dispatches commands' do
        expect(robot).to receive(:place).with(0, 0, 'NORTH')
        command_parser.perform
      end
    end

    context 'with invalid commands and valid commands' do
      let(:input) {
        'CHICKEN 0,0,NORTH
        DESTROY
        RM -RF /
        PLACE 0,0,NORTH'
      }

      it "doesn't dispatch invalid commands, but dispatches the valid commands" do
        expect(robot).not_to receive(:chicken)
        expect(robot).not_to receive(:destroy)
        expect(robot).not_to receive(:rm)
        expect(robot).to receive(:place)
        command_parser.perform
      end
    end

    context 'with invalid commands with whitespace' do
      let(:input) {
        '1234

        '
      }

      it "doesn't raise an error" do
        expect {
          command_parser.perform
        }.not_to raise_error
      end
    end
  end
end
