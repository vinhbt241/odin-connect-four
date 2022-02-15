class ConnectFour
  WHITE_CIRCLE = "○"
  BLACK_CIRCLE = "●"
  RED_CIRCLE = "\e[#{31}m#{BLACK_CIRCLE}\e[0m"
  YELLOW_CIRCLE = "\e[#{33}m#{BLACK_CIRCLE}\e[0m"

  def initialize()
    @board = create_board()
    @player_turn = 1
    @player_won = false
    @victory_message = "TIE"

    # until board_full?(@board)
    #   system 'clear'
    #   display_board(@board)
    #   choosen_col = -1
    #   loop do
    #     choosen_col = get_input().to_i - 1
    #     break unless full_column?(@board, choosen_col)
    #     puts "Invalid input, column is already full"
    #   end
    #   update_board(@board, @player_turn, choosen_col)
    #   if player_won?(@board, choosen_col)
    #     @victory_message = @player_turn == 1 ? "PLAYER 1 WON!" : "PLAYER 2 WON!"
    #     break
    #   end
    #   switch_turn()
    # end

    # system 'clear'
    # display_board(@board)
    # puts @victory_message
  end

  def create_board()
    Array.new(6) { Array.new(7, WHITE_CIRCLE) }
  end

  def display_board(board)
    puts "CONNECT FOUR!"
    board.each { |row| puts row.join(" ") }
    puts (1..7).to_a.join(" ")
  end

  def switch_turn()
    @player_turn = @player_turn == 1 ? 2 : 1
  end

  def get_input()
    print "Type in your choice: "
    loop do
      player_input = gets.chomp
      return player_input if player_input.match?(/[1-7]/)
      print "Invalid input, input must be between 1 and 7: "
    end
  end

  def full_column?(board, col_i)
    board.each do |row|
      return false if row[col_i] == WHITE_CIRCLE
    end
    true
  end

  def update_board(board, player_turn, col_i)
    row_j = board.length - 1
    until board[row_j][col_i] == WHITE_CIRCLE
      row_j -= 1
    end
    board[row_j][col_i] = player_turn == 1 ? RED_CIRCLE : YELLOW_CIRCLE
  end

  def board_full?(board)
    board.each do |row|
      return false if row.any?(WHITE_CIRCLE)
    end
    true
  end

  def player_won?(board, col)
    row = 0
    while board[row][col] == WHITE_CIRCLE
      row += 1
    end

    cmp_circle = board[row][col]

    #Check horizontally
    if col - 3 >= 0
      return true if board[row][col - 3..col].all?(cmp_circle)
    elsif col + 3 < 7
      return true if board[row][col..col + 3].all?(cmp_circle)
    end

    #Check vertically
    if row + 3 < 6
      count_v = 1
      current_row = row + 1
      until current_row == row + 4
        count_v += 1 if board[current_row][col] == cmp_circle
        current_row += 1
      end
      return true if count_v == 4
    end

    #Check diagonal
    count_d = 1

    if row + 3 < 6 && col - 3 >= 0

      current_r = row + 1
      current_c = col - 1
      until current_r == row + 4 && current_c == col - 4
        count_d += 1 if board[current_r][current_c] == cmp_circle
        current_r += 1
        current_c -= 1
      end
      return true if count_d == 4
    elsif row + 3 < 6 && col + 3 < 7
      current_r = row + 1
      current_c = col + 1
      until current_r == row + 4 && current_c == col + 4
        count_d += 1 if board[current_r][current_c] == cmp_circle
        count_r += 1
        count_c += 1
      end
      return true if count_d == 4
    end

    false
  end
end

# game = ConnectFour.new()



