require_relative 'game.rb'
require_relative 'player.rb'

include TicTacToe

Game.new(Player,Player).print_board
