# rubocop:disable Layout/LineLength, Metrics/BlockLength

require '../player'

describe Player do
  let(:game) { double('Game') }
  subject(:player) { described_class.new('test', game, 'x') }

  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#select_position' do
    context 'when board is new and selection is 9' do
      before do
        allow(player).to receive(:print)
        allow(player).to receive(:puts)
        selection = '9'
        allow(player).to receive(:gets).and_return(selection)

        allow(game).to receive(:free_positions).and_return([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end

      it 'returns 9' do
        expect(player.select_position).to eq(9)
      end
    end

    context 'when choosing an availabe position' do
      before do
        allow(player).to receive(:print)
        allow(player).to receive(:puts)
        selection = '4'
        allow(player).to receive(:gets).and_return(selection)
        allow(game).to receive(:free_positions).and_return([3, 4, 7, 8, 9])
      end

      it 'returns selection' do
        expect(player.select_position).to eq(4)
      end
    end

    context 'when choosing an occupied position' do
      before do
        allow(player).to receive(:print)
        allow(player).to receive(:puts)
        occupied_position = '4'
        valid_input = '7'
        allow(player).to receive(:gets).and_return(occupied_position, valid_input)
        allow(game).to receive(:free_positions).and_return([3, 7, 8, 9])
        allow(game).to receive(:print_board)
      end

      it 'completes loop and dispalys error meessage once' do
        expect(player).to receive(:puts).with('Invalid selection, please pick a number on the board!').once
        player.select_position
      end
    end

    context 'when user inputs 2 invalid values, then a valid value' do
      before do
        allow(player).to receive(:print)
        allow(player).to receive(:puts)
        letter = 'x'
        invalid_position = '12'
        valid_input = '7'
        allow(player).to receive(:gets).and_return(invalid_position, letter, valid_input)
        allow(game).to receive(:free_positions).and_return([3, 7, 8, 9])
        allow(game).to receive(:print_board)
      end

      it 'completes loop and dispalys error meessage once' do
        expect(player).to receive(:puts).with('Invalid selection, please pick a number on the board!').twice
        player.select_position
      end
    end
  end
end
