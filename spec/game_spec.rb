# rubocop:disable Layout/LineLength, Metrics/BlockLength

require '../player'
require '../game'

describe TicTacToe do
  describe TicTacToe::Game do
    subject(:game) { described_class.new(Player, Player) }

    before do
      allow_any_instance_of(TicTacToe::Game).to receive(:gets).and_return('test')

      allow_any_instance_of(TicTacToe::Game).to receive(:puts)
    end

    describe '#initialize' do
      # Initialize -> No test necessary when only creating instance variables.
    end

    describe '#current_player' do
      let(:players) { game.instance_variable_get(:@players) }

      context 'when current palyer id is 0' do
        before do
          game.instance_variable_set(:@current_player_id, 0)
        end

        it 'returns player 1 object' do
          player1 = players[0]
          expect(game.current_player).to be(player1)
        end
      end

      context 'when current player id is 1' do
        before do
          game.instance_variable_set(:@current_player_id, 1)
        end

        it 'returns player 2 object' do
          player2 = players[1]
          expect(game.current_player).to be(player2)
        end
      end
    end

    describe '#other_player_id' do
      context 'when current player id is 1' do
        before do
          game.instance_variable_set(:@current_player_id, 1)
        end

        it 'returns 0' do
          expect(game.other_player_id).to eq(0)
        end
      end

      context 'when current player id is 0' do
        before do
          game.instance_variable_set(:@current_player_id, 0)
        end

        it 'returns 1' do
          expect(game.other_player_id).to eq(1)
        end
      end
    end

    describe '#switch_player' do
      context 'when current player id is 1' do
        before do
          game.instance_variable_set(:@current_player_id, 1)
          game.switch_player
        end

        it 'changes @current_player_id to 0' do
          current_id = game.instance_variable_get(:@current_player_id)
          expect(current_id).to eq(0)
        end
      end
    end

    describe '#play' do
      # Public Script Method -> No test necessary, but all methods inside should
      # be tested.
    end

    context 'when current player id is 0' do
      before do
        game.instance_variable_set(:@current_player_id, 0)
        game.switch_player
      end

      it 'changes @current_player_id to 1' do
        current_id = game.instance_variable_get(:@current_player_id)
        expect(current_id).to eq(1)
      end
    end

    describe '#free_positions' do
      context 'when board is new' do
        it 'returns indexes 1-9' do
          expect(game.free_positions).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
        end
      end

      context 'when positions 5,7, & 8 are taken' do
        before do
          game.instance_variable_set(:@board, [nil, nil, nil, nil, nil, 'x', nil, 'o', 'o', nil])
        end

        it 'returns positions 1-4, & 9' do
          expect(game.free_positions).to eq([1, 2, 3, 4, 6, 9])
        end
      end
    end

    describe '#board_full' do
      context 'when board is new' do
        it 'is not full' do
          expect(game).not_to be_full
        end
      end

      context 'when board is partially used' do
        before do
          game.instance_variable_set(:@board, [nil, 'x', nil, nil, nil, 'o', nil, nil, nil, 'x'])
        end

        it 'is not full' do
          expect(game).not_to be_full
        end
      end

      context 'when indexes 1-9 are full' do
        before do
          game.instance_variable_set(:@board, %w[nil x x o o x o x o o])
        end

        it 'is full' do
          expect(game).to be_full
        end
      end
    end

    # Board array size is 10 but index 0 is ignored for ease of use.
    describe '#game_over?' do 
      context 'when board is new' do
        it 'is not game over' do
          expect(game).not_to be_game_over
        end
      end

      context 'when board is partially played' do
        before do
          game.instance_variable_set(:@board, [nil, 'x', nil, nil, nil, 'o', nil, nil, nil, 'x'])
        end

        it 'is not game over'do
          expect(game).not_to be_game_over
        end
      end

      context 'when there is a horizontal 3-in-a-row' do
        before do
          game.instance_variable_set(:@board, [nil, 'x', 'x', 'x', nil, 'o', nil, nil, 'o', 'x'])
        end

        it 'is game over' do
          expect(game).to be_game_over
        end
      end

      context 'when there is a vertical 3-in-a-row' do
        before do
          game.instance_variable_set(:@board, [nil, 'o', 'x', nil, 'o', 'x', nil, 'o', nil, 'x'])
        end

        it 'is game over' do
          expect(game).to be_game_over
        end
      end

      context 'when there is a diagonal 3-in-a-row' do
        before do
          game.instance_variable_set(:@board, [nil, nil, 'x', 'o', nil, 'o', nil, 'o', 'x', 'x'])
        end

        it 'is game over' do
          expect(game).to be_game_over
        end
      end
    end
  end
end
