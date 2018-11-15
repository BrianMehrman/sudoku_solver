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
    let(:solver) { Solver.new('./puzzles/easy_01.txt') }

    context 'validates the row' do
      it 'returns `nil` with empty cell' do
        expect(solver.validate_cell(0, 0)).to eq(nil)
      end

      it 'returns `false` when row contains same value' do
        solver.puzzle[0][0] = "6"
        expect(solver.validate_cell(0, 0)).to eq(false)
      end

      it 'returns `false` when column contains same value' do
        solver.puzzle[0][0] = "5"
        expect(solver.validate_cell(0, 0)).to eq(false)
      end

      it 'returns `false` when the 9x9 grid contains the same value' do
        solver.puzzle[0][0] = "8"
        expect(solver.validate_cell(0, 0)).to eq(false)
      end

      it 'returns `true` when value is not found in row, column, or grid' do
        solver.puzzle[0][0] = "3"
        expect(solver.validate_cell(0,0)).to eq(true)
      end
    end
  end
end
