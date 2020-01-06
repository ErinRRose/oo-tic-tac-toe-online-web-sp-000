class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
      user_input.to_i - 1
    end

    def move(index, current_player)
      @board[index] = current_player
    end

    def position_taken?(location)
      @board[location] != " " && @board[location] != ""
    end

    def valid_move?(index)
      index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
      @board.count{|token| token == "X" || token == "O"}

      turns = 0
      @board.each do |token|
        if token == "X" || token == "O"
          turns += 1
        end
    end
    turns
    end

    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
      puts "Please enter 1-9:"
      input = gets.strip
      index = input_to_index(input)
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
          turn
        end
      end

      def won?
        WIN_COMBINATIONS.detect do |combo|
          @board[combo[0]] == @board[combo[1]] &&
          @board[combo[1]] == @board[combo[2]] &&
          position_taken?(combo[0])
        end
      end

      def full?
        @board.all?{|token| token == "X" || token == "O"}
      end

      def draw?
        full? && !won?
      end

      def over?
        won? || full?
      end

      def winner
        if winning_combo = won?
          @board[winning_combo.first]
        end
      end

      def play

        until over?
          turn
          if draw?
            break
          end
        end

        if won?
          puts "Congratulations #{winner}!"
        else draw?
          puts "Cat's Game!"
        end
      end
end
