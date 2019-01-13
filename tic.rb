$stdout.sync = true
class Board 
    def initialize
        @spaces = Array.new(9, "-") 
    end
    def spaces
        return @spaces
    end
    
    def generate_board
        board = ""
        (0..8).step(3) do |i|
          board += "| #{@spaces[i]} | #{@spaces[i + 1]} | #{@spaces[i + 2]} |\n"
        end
        puts board + "\n\n\n"
    end

    def add_symbol(position,symbol)
        @spaces[position] = symbol
    end
    def space_taken?(position,symbol)
        return @spaces[position] == "X" || @spaces[position] == "O"
    end
end
class Play
    def initialize
        @a = Board.new
        @turn_number = 0
    end
    @@winning_positions = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]
      ]
    @@key_values = {"1" => 6, "2" => 7, "3" => 8, "4" => 3, "5" => 4, "6" => 5, "7" => 0, "8" => 1, "9" => 2}

    def start_game
        @winner = false
        i = 0
        @a.generate_board
        @player_name = "Player 1 (\"X\")"
        while i < 9 && @winner == false
            ask_input
            @turn_number += 1
            i += 1
            @a.generate_board
            check_winner
        end
        winner_message

    end
    def ask_input
        current_player
        puts "#{@player_name}"
        key = gets.chomp.to_s
        input = @@key_values[key]
        if (0..9) === input && @a.space_taken?(input, current_player) == false
            @a.add_symbol(input, current_player)
        else
            puts "That square is taken, please pick another"
            ask_input
        end
    end
    def current_player
        if @turn_number % 2 == 0
            @player_name = "| Player 1 (\"X\") |"
            return "X"
        else
            @player_name = "| Player 2 (\"O\") |"
            return "O"
        end

    end
    def check_winner
        @@winning_positions.each do |i|
            @winner = true if i.all? { |x| @a.spaces[x] == "X"}
            @winner = true if i.all? { |x| @a.spaces[x] == "O"}
        end
    end
    def winner_message
        if @winner == true
            puts "Congratulations #{@player_name}, you have won."
        else
            puts "Cat's game, Sorry"
        end
    end
end
ab = Play.new
ab.start_game