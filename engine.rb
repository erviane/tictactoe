require "./board.rb"

class Engine < Board
  
  def move(index, player_character)
    @board[index] = player_character
  end
  
  def turn    
    puts "\nPlease enter 1-9:"
    input = gets.chomp
    index = (input.to_i) - 1
    if index.between?(0,8) &&  @board[index] = " " 
      move(index, current_player)
    else
      turn
    end
    display_board
  end

  def current_player
    counter = 0
    @board.each do |current|
      if current == "X" || current == "O"
        counter += 1
      end
    end
    counter % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.each do |moves|
      if @board[moves[0]] == "X" && @board[moves[1]] == "X" && @board[moves[2]] == "X"
        return moves
      end
      if @board[moves[0]] == "O" && @board[moves[1]] == "O" && @board[moves[2]] == "O"
        return moves
      end
    end
    false
  end

  def full?
    @board.all? { |space| space == "X" || space == "O"}
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    if draw? || !over?
      return nil
    else
      return @board[won?[0]]
    end
  end

  def play
    while !over?
      turn
    end
    if won?
      puts "Congratulations player #{winner}!"
    end
    if draw?
      puts "Draw!"
    end
  end
end

Engine.new.play