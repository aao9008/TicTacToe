module TicTacToe
    LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

    class game
        def initialization(player_class_1, player_class_2)
            @board = Array.new(10)

            @current_player_id = 0 

            @players = [player_class_1.new(self, "X"), player_class_2.new(self,"O")]
        end
        att_reader :board, :current_player

        def current_player
            @players[current_player]
        end 

        def other_player_id
            1 - @current_player_id
        end

        def switch_player
            @current_player_id = other_player_id
        end