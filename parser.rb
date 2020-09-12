# frozen_string_literal: true

class Parser
  def self.parse(file)
    new(file).start
  end

  def initialize(file)
    @file = file
  end

  def start
    file
  end

  private

  attr_reader :file
end
