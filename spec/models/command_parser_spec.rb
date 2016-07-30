require 'spec_helper'

RSpec.describe CommandParser do
  let(:command_parser) { CommandParser.new(input) }
  let(:instructor) { double(:instructor) }

  before :each do
    allow(Instructor).to receive(:new).and_return(instructor)
  end

  context 'with valid commands separated by newlines' do
    let(:input) {
'PLACE 0,0,NORTH
MOVE
REPORT'
    }

    it 'dispatches commands' do
      expect(instructor).to receive(:place).with(0, 0, 'NORTH')
      expect(instructor).to receive(:move)
      expect(instructor).to receive(:report)
      command_parser.perform
    end
  end

  context 'with valid commands separated by newlines, with some extra spacing' do
    let(:input) {
'PLACE 0, 0, NORTH'
    }

    it 'dispatches commands' do
      expect(instructor).to receive(:place).with(0, 0, 'NORTH')
      command_parser.perform
    end
  end

  context 'with invalid commands and valid commands' do
    let(:input) {
'CHICKEN 0,0,NORTH
DESTROY
RM -RF /
PLACE 0,0,NORTH
'
    }

    it "doesn't dispatch invalid commands, but dispatches the valid commands" do
      expect(instructor).not_to receive(:chicken)
      expect(instructor).not_to receive(:destroy)
      expect(instructor).not_to receive(:rm)
      expect(instructor).to receive(:place)
      command_parser.perform
    end
  end
end
