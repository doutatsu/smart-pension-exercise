# frozen_string_literal: true

require './log_parser'

unless ARGV[0]
  puts 'Please provide file path'
  return
end

file = ARGV[0]
mode = ARGV[1].nil? ? :most_unique_visited : ARGV[1].to_sym

puts LogParser.parse(file, mode).join("\n")
