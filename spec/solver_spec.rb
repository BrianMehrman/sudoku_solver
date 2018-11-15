require 'spec_helper'
require './solver'

describe Solver do
  describe 'new' do
    it 'loads the puzzle file' do
      solver = Solver.new('./puzzles/easy_01.txt')
      expect(solver.puzzle.size).to eq(9)
    end
  end

  describe '#validate_cell' do
    it 'validates the row' do

    end
  end
end
