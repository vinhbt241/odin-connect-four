require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#create_board' do
    subject(:game) { described_class.new() }
    
    context 'When the function is called' do
      it 'Create an array 6x7' do
        board = game.create_board
        expect(board.length).to eq(6)
        expect(board[0].length).to eq(7)
      end

      it 'Every element in array is blank circle' do
        board = game.create_board
        board.each do |row|
          expect(row.all?('○')).to eq(true)
        end
      end
    end
  end

  describe '#display_board' do
    subject(:game) { described_class.new() }
    let(:board) { game.create_board }

    context 'When display board' do
      it 'call puts 8 times' do
        expect(STDOUT).to receive(:puts).exactly(8).times
        game.display_board(board)
      end
    end
  end

  describe '#get_input' do
    subject(:game) { described_class.new() }

    context 'When user input valid number' do
      before do
        valid_input = '3'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'Stop loop and does not display error message' do
        choice_message = "Type in your choice: "
        error_message = "Invalid input, input must be between 1 and 7: "
        expect(game).to receive(:print).with(choice_message).once
        expect(game).not_to receive(:print).with(error_message)
        game.get_input
      end
    end

    context 'When user input is invalid once, then valid' do
      before do
        invalid_input = 'a'
        valid_input = '3'
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'Complete loops and display error message once' do
        choice_message = "Type in your choice: "
        error_message = "Invalid input, input must be between 1 and 7: "
        expect(game).to receive(:print).with(choice_message).once
        expect(game).to receive(:print).with(error_message).once
        game.get_input
      end
    end
  end

  describe '#full_column?' do
    subject(:game) { described_class.new() }

    context 'When the choosen column is not full' do
      let(:board) { game.create_board }
      it 'return false' do
        expect(game.full_column?(board, 3)).to eq(false)
      end
    end

    context 'when the choosen column is full' do
      let(:board) { Array.new(6) { Array.new(7, '●') } }
      it 'return true' do
        expect(game.full_column?(board, 3)).to eq(true)
      end
    end
  end
end
