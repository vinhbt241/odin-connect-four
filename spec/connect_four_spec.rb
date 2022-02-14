require_relative '../lib/connect_four'

describe 'create_board' do
  context 'When called' do
    let(:board) { create_board() }

    it 'Return an array 6 rows and 7 column' do  
      expect(board.length).to eq(6)
      expect(board[0].length).to eq(7)
    end

    it 'Every element in array is ○' do
      board.each do |row|
        expect(row.all?('○')).to eq(true)
      end
    end
  end
end

describe 'display_board' do
  context 'when the board is displayed' do
    let(:board) { create_board() }

    it 'Print all six row' do
      expect(STDOUT).to receive(:puts).exactly(6).times
      display_board(board)
    end
  end
end
