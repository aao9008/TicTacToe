module TicTacToe
    # Each index contains array of winning values. If player controls all winning vlaues for any given line array in Lines, player has won.
    LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

    class Game
        def initialize(player_class_1, player_class_2)

            # Board has 9 postions total, we will ignore index 0 for ease of use.
            @board = Array.new(10)

            # This id will be used to access player object in players array
            @current_player_id = 0 

            # Ask first player for their name
            puts "Player 1 enter your name"
            player_1 = gets.chomp

            puts ""

            # Ask second player for their name
            puts "Player 2 enter your name"
            player_2 = gets.chomp

            # Create array of player objects
            @players = [player_class_1.new(player_1,self, "X"), player_class_2.new(player_2,self,"O")]
        end
        attr_reader :board, :current_player_id 

        # Current player will be used to run marker placement functions
        def current_player
            @players[current_player_id]
        end 

        # Other player will be next player to have a turn
        def other_player_id
            1 - current_player_id
        end

        # Make the other player the new current player
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
            puts ""
            # Intial game start message
            puts "#{current_player.name} goes first"

            puts ""

            #Print inital game board
            print_board

            loop do
                # Ask for position and place marker 
                place_player_marker(current_player)
                
                # If player is winner after palcing their marker end game and display winner message
                if player_has_won?(current_player)
                  puts "#{current_player.name} wins!"
                  print_board
                  return
                # If there is no winner and board is full delclare draw
                elsif board_full?
                  puts "It's a draw."
                  print_board
                  return
                end
                
                # If there is no winner and board is not full repeat all steps again for the next player 
                switch_player
            end
        end 

        # Return a list of indexes in @board array that are free (aka nil)
        def free_positions
            (1..9).select {|position| @board[position].nil?}
        end

        # Place player marker on the board
        def place_player_marker(player)
            # Ask player for postion choice
            selection = player.select_postion

            # Declare what player has chosen
            puts ("#{player.name} places #{player.marker} on position #{selection} \n")

            # Update board postion ownership in @board array
            @board[selection] = player.marker

            # Print updated board
            print_board
            # This provides a space to make console look cleaner
            puts("")
        end

        # Check if there are any open positions left
        def board_full?
            free_positions.empty?
        end 

        def player_has_won?(player)
            # Check if any winning line...
            LINES.any? do |line|
                #...has all postions when compared to the board owned by the same player 
                line.all? {|position| @board[position] == player.marker}
            end 
        end 
    end
end 
