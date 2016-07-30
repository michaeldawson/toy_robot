#!/usr/bin/env ruby
require './lib/command_parser'

raise "You need to pass a file to read as an argument. E.g: `./toy_robot.rb command.sample`" unless ARGV.length == 1

instructions = File.read(ARGV[0])
CommandParser.perform(instructions)
