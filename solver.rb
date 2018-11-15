#!/usr/bin/env ruby
require 'pry'

class Solver
  attr_accessor :puzzle

  NUMBERS = %w(1 2 3 4 5 6 7 8 9)

  def initialize(file)
    @puzzle = []
    load(file)
    print_puzzle
  end

  def load(file)
    io = File.open(file)
    read(io.read)
  end

  def read(string)
    rows = string.split("\n")

    rows.each_with_index do |row, idx|
      @puzzle[idx] = row.chars.map { |c| c == '.' ? nil : c }
    end
  end

  def solve_puzzle
    print_puzzle
    solve
    print_puzzle
  end


  # @return [Boolean] if cell is cell is valid or not. If cell is empty nil is returned.
  def validate_cell(cell, x, y)
    # cell = @puzzle[y][x]

    # is cell empty
    return nil if cell.nil?

    row = get_row(x, y)

    # check that cell is not used in remaining cells in row
    return false if row.include?(cell)

    columns = get_columns(x, y)

    return false if columns.include?(cell)

    # check grid
    grid = get_grid(x, y)

    return false if grid.include?(cell)

    true
  end

  def print_puzzle
    system("clear")
    out = ""
    @puzzle.each_with_index do |row, i|
      out += " "

      row.each_with_index do |c, j|
        c = " " if c.nil?

        if j == 2 || j == 5
          out += "#{c} | "
        else
          out += "#{c} "
        end
      end

      out += "\n"

      if i == 2 || i == 5
        out += "-------|-------|-------\n"
      end
    end

    print out
  end

  private

  def solve
    answers = {}
    @puzzle.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        next if cell
        grid   = get_grid(x, y)
        row    = get_row(x, y)
        column = get_columns(x, y)
        cell_answers = NUMBERS - grid - row - column

        if cell_answers.size == 1
          @puzzle[y][x] = cell_answers.first
        else
          answers[[x, y]] = cell_answers
        end
      end
    end

    print_puzzle

    sleep(1)

    solve unless answers.empty?
  end

  def get_row(x,y)
    row = @puzzle[y].clone
    # removing current cell
    row.slice!(x)
    row.compact!
    row
  end

  def get_columns(x, y)
    columns = @puzzle.map do |row|
      row[x]
    end

    columns.slice!(y)
    columns.compact!
    columns
  end

  def get_grid(x, y)
    x_t = x/3
    y_t = y/3

    cells = []
    3.times do |xi|
      3.times do |yi|
        # apply vector transformation to get grid cell
        _x = xi + (3 * x_t)
        _y = yi + (3 * y_t)

        # skip cell that matchs x and y inputs
        cells << @puzzle[_y][_x] unless _x == x && _y == y
      end
    end
    cells
  end
end

if __FILE__ == $0
  if ARGV[0] && File.exists?(ARGV[0])
    solver = Solver.new(ARGV[0])
    solver.solve_puzzle
  else
    print 'No file provided'
  end
end
