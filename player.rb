class Player
    attr_accessor :name, :marker

    def initialize (name, game, marker)
        @name = name
        @game = game
        @marker = marker
    end

    def select_postion 
        # Ask user for valid postion until user provides valid input
        loop do 
            # Ask user for postion selection
            print "#{name} select your position: "
            # Get and convert user input to integer
            selection = gets.to_i

            puts ""
              
            # Check board for open index (aka nil values), if @board[selection] is nil (aka open) return selection
            return selection if @game.free_positions.include?(selection)

            puts "Invalid selection, please pick a number on the board!"
            @game.print_board
            
        end 
    end 
end 