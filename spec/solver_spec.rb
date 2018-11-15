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
      it 'returns `false` with empty cell' do
        expect(solver.validate_cell(0,0)).to eq(false)
      end

      it 'returns `false` when row contains same value' do
        solver.puzzle[0][0] = "6"
        solver.print
        expect(solver.validate_cell(0,0)).to eq(false)
      end
    end
  end
end
