require 'colorize'

class ConnectFour
  WHITE_CIRCLE = "○"
  BLACK_CIRCLE = "●"
  RED_CIRCLE = "\e[#{31}m#{BLACK_CIRCLE}\e[0m"
  YELLOW_CIRCLE = "\e[#{33}m#{BLACK_CIRCLE}\e[0m"

  def initialize()
    @board = create_board()
    @player_turn = 1
    @player_won = false

    until board_full?(@board) || player_won?(@board)
      system 'clear'
      display_board(@board)
      choosen_col = -1
      loop do
        choosen_col = get_input().to_i - 1
        break unless full_column?(@board, choosen_col)
        puts "Invalid input, column is already full"
      end
      update_board(@board, @player_turn, choosen_col)
      switch_turn()
    end
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

  def player_won?(board)
    cmp_circle_h = RED_CIRCLE
    cmp_circle_v = RED_CIRCLE
    count_h = 0
    count_v = 0
    count_d = 0
    
    board.each do |row|
      row.each do |current_circle|
        if cmp_circle_h == current_circle
          count_h += 1
        else
          cmp_circle_h = current_circle unless current_circle == WHITE_CIRCLE
          count_h = 1
        end
        return true if count_h == 4
      end
    end

    # columns = board[0].length
    # columns.times do |col|
    #   board.each_index do |row|
    #     if cmp_circle_v == board[row][col]
    #       count_v += 1
    #     else
    #       cmp_circle_v = board[row][col] unless board[row][col] = WHITE_CIRCLE
    #       count_v = 1
    #     end
    #     return true if count_v == 4
    #   end
    # end
    
    false
  end
end

game = ConnectFour.new()



