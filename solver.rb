#!/usr/bin/env ruby
require 'pry'

class Solver
  attr_accessor :puzzle

  def number_set
    %w(1 2 3 4 5 6 7 8 9)
  end

  def initialize(file)
    @puzzle = []
    load(file)
    print
  end

  def load(file)
    io = File.open(file)

    string = io.read
    read(string)
  end

  def read(string)
    rows = string.split("\n")

    rows.each_with_index do |row, idx|
      @puzzle[idx] = row.chars.map { |c| c == '.' ? nil : c }
    end
  end

  # @return [Boolean] if cell is valid
  def validate_cell(x, y)
    cell = @puzzle[y][x]

    # is cell empty
    return false if cell.nil?

    row = get_row(y)

    # removing current cell
    row.slice!(x)

    # check that cell is not used in remaining cells in row
    if row.include?(cell)
      return false
    end

    column = get_column(x)
    column.slice!(y)

    if column.include?(cell)
      return false
    end

    # check grid
    true
  end

  def get_row(y)
    @puzzle[y]
  end

  def get_column(x)
    @puzzle.map do |row|
      row[x]
    end
  end

  def print
    puts ""
    @puzzle.each_with_index do |row, i|
      row_str = " "

      row.each_with_index do |c, j|
        c = " " if c.nil?

        if j == 2 || j == 5
          row_str += c + " | "
        else
          row_str += c
        end
      end

      puts row_str

      if i == 2 || i == 5
        puts "-----|-----|-----"
      end
    end
  end
end
