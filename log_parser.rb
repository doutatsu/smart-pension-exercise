# frozen_string_literal: true

require 'pry'

class LogParser
  def self.parse(file, mode)
    new(file, mode).start
  end

  def initialize(file, mode)
    @file = file
    @mode = mode
  end

  def start
    case mode
    when :most_visited
      most_visited_pages
    when :most_unique_visited
      most_unique_visited_pages
    when :visits_per_ip
      visits_per_ip
    else
      raise 'Incorrect mode provided'
    end
  end

  def most_visited_pages
    page_counts =
      parsed_log
      .group_by(&:first)
      .transform_values(&:count)
      .sort_by { |count| -count.last }

    page_counts.map { |route, count| "#{route} #{count} visits" }
  end

  def most_unique_visited_pages
    page_counts =
      tally_routes
      .transform_values(&:keys)
      .values
      .group_by(&:first)
      .transform_values(&:count)
      .sort_by { |count| -count.last }

    page_counts.map { |route, count| "#{route} #{count} unique visits" }
  end

  def visits_per_ip
    tally_routes.map do |ip, route_counts|
      count_string =
        route_counts
        .sort_by { |count| -count.last }
        .to_h
        .transform_values { |count| "#{count} unique visits" }
        .to_a
        .join(' | ')

      "[#{ip}] #{count_string}"
    end
  end

  private

  attr_reader :file
  attr_reader :mode

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
