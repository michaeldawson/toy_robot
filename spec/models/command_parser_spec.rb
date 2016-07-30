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
      command_parser.perform
    end
  end
end
