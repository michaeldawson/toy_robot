require_relative 'robot'

class CommandParser
  COMMAND_REGEX = /(\S+)\s*(.*)/
  COMMAND_WHITELIST = %i(place move report left right)

  def self.perform(input)
    new(input).perform
  end

  def initialize(input)
    @input = input
  end

  def perform
    commands.each do |command, args|
      robot.send(command, *args) if COMMAND_WHITELIST.include?(command)
    end
  end

  private

  attr_reader :input

  def commands
    input.split("\n").map { |command_string| parse(command_string) }
  end

  def parse(command_string)
    matches = COMMAND_REGEX.match(command_string)
    command, arguments = matches ? matches.captures : nil
    [format_command(command), format_arguments(arguments)]
  end

  def format_command(command)
    command.downcase.to_sym
  end

  def format_arguments(arguments)
    arguments.split(',').map do |argument|
      argument.strip!
      numeric?(argument) ? argument.to_i : argument
    end
  end

  def robot
    @robot ||= Robot.new
  end

  def numeric?(string)
    !! /[0-9]+\z/.match(string)
  end
end
