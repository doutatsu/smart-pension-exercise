# frozen_string_literal: true

require 'pry'

class Parser
  def self.parse(file)
    new(file).start
  end

  def initialize(file)
    @file = file
  end

  def start
    tally_routes
  end

  private

  attr_reader :file

  def log
    File.readlines(file)
  end

  def parsed_log
    log.map { |l| l.split(' ') }
  end

  def grouped_by_ip
    Hash[
      parsed_log.group_by(&:last).collect do |key, values|
        [key, values.collect(&:first)]
      end
    ]
  end

  def tally_routes
    grouped_by_ip.each_with_object({}) do |(ip, routes), enum|
      enum[ip] = routes.group_by(&:itself).transform_values(&:count)
    end
  end
end
