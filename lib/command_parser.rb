require 'instructor'

class CommandParser
  def initialize(input)
    @input = input
  end

  def perform

  end

  private

  attr_reader :input

  def commands
    input.split("\n")
  end
end
