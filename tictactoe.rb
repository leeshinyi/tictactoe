class Player
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end
end

class Board 
  attr_reader :board, :player_1, :player_2
  attr_accessor :turns

  def initialize(player1, player2)
    puts ""
    @player_1 = player1
    @player_2 = player2

    @board = Array.new
    9.times { @board << " " }

    @turns = 1

    sample_board
    show_board
  end

  def sample_board
    puts "Enter a number between 1 to 9 to mark your move."
    puts "-----------"
    puts " 1 | 2 | 3 "
    puts "---+---+---"
    puts " 4 | 5 | 6 "
    puts "---+---+---"
    puts " 7 | 8 | 9 "
    puts "-----------"
    puts ""
    puts "Let's Play"
  end

  def show_board
    puts ""
    puts "-----------"
    puts " #{board[0]} | #{board[1]} | #{board[2]}"
    puts "---+---+---"
    puts " #{board[3]} | #{board[4]} | #{board[5]}"
    puts "---+---+---"
    puts " #{board[6]} | #{board[7]} | #{board[8]}"
    puts "-----------"
  end

  def play
    while @turns < 10
      player = @turns.odd? ? player_1 : player_2
      puts ""
      puts "Player #{player.marker}'s turn."
      put_marker(player.marker)
      @turns += 1 if !end_game?
    end  
  end

  def get_position
    while
      position = gets.to_i - 1 

      case 
      when !position.between?(0,9)
        puts "Invalid move, please choose a position number from 1 to 9!"
        next
      when !free?(position) 
        puts "Invalid move, position is already taken. Please choose a different position!"
        next
      end

      break 
    end
    return position
  end

  def free?(position)
    board[position] == " "
  end

  def put_marker(marker)
    board[get_position] = marker
    show_board
  end

  def win?(player)
    winning_combinations = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    winning_combinations.any? do |wc| 
      wc.all? { |i| board[i - 1] == player.marker }
    end
  end

  def draw?
    board.all? { |i| !(i == " ") }
  end

  def end_game?
    case 
    when win?(@player_1)
      puts "Player 1 wins!"
    when win?(@player_2)
      puts "Player 1 wins!"
    when draw? && !win?(player_1) && !win?(player_2)
      puts "It's a draw!"
    end

    new_game? if all_done?
  end

  def all_done?
    win?(@player_1) || win?(@player_2) || (draw? && !win?(player_1) && !win?(player_2))
  end

  def new_game?
    puts "Do you want play again? Yes or no?"
    new_game = gets.chomp
    case new_game
    when "Yes", "yes", "Y", "y"
      game = Board.new(Player.new("X"), Player.new("O"))
      game.play
    when "No", "no", "N", "n"
      abort("Thanks for playing!")
    else
      puts "Answer is invalid!"
      new_game?
    end  
  end
end


game = Board.new(Player.new("X"), Player.new("O"))
game.play