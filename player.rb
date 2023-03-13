class Player
    attr_accessor :name, :mark

    def initialization (name, marker)
        @name = name
        @marker = marker
    end

    def display_player
        puts "Player #{name} whas joined the game and has chosen #{marker} as his marker."
    end
end