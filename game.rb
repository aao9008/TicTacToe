module TicTacToe
    LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

    class Game
        def initialize(player_class_1, player_class_2)

            # Board has 9 postions total, we will ignore index 0 for ease of use.
            @board = Array.new(10)

            @current_player_id = 0 

            puts "Player 1 enter your name"
            player_1 = gets

            puts "Player 2 enter your name"
            player_2 = gets 

            @players = [player_class_1.new(player_1,self, "X"), player_class_2.new(player_2,self,"O")]

            puts @players[0].name, @players[1].name
        end
        attr_reader :board, :current_player_id 

        def current_player
            @players[current_player_id]
        end 

        def other_player_id
            1 - @current_player_id
        end

        def switch_player
            @current_player_id = other_player_id
        end

        # This function prints the board accoarding to avialable spots on the board
        def print_board
            col_separator, row_separator = " | ", "--+---+--"
        
            # Check board record and return either player marker if index not nil or index if index value == nil 
            label_for_position = lambda{|position| @board[position] ? @board[position] : position}
        
            # This varaible holds function that will take row position and return row label concated with col_separator 
            row_for_display = lambda{|row| row.map(&label_for_position).join(col_separator)}
        
            # Row positions of our grid 
            row_positions = [[1,2,3], [4,5,6], [7,8,9]]
            rows_for_display = row_positions.map(&row_for_display)
            puts rows_for_display.join("\n" +row_separator + "\n") 
        end


        # This function starts the game 
        def play
            loop do
                place_player_marker(current_player)
                
                if player_has_won?(current_player)
                  puts "#{current_player} wins!"
                  print_board
                  return
                elsif board_full?
                  puts "It's a draw."
                  print_board
                  return
                end
                
                switch_players!
            end
        end 

        def free_positions
            (1..9).select {|position| @board[position].nil?}
        end

        def place_player_marker(player)
            selection = current_player.select_postion

            puts "#{player.name} places a #{player.marker} on position #{select_postion}"

            @board[selection] = current_player.marker

            print_board
        end

        # Check if there are any open positions left
        def board_full?
            free_positions.len == 0? true : false
        end 

        def player_has_won?(player)
            # Check if any winning line...
            LINES.any? do |line|
                #...has all postions when compared to the board owned by the same player 
                line.all? {|positon| @board[position] == player.marker}
            end 
        end 


    
    end
end 
