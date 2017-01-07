RSpec.describe(Dry::Monads::List) do
  list = described_class

  include Dry::Monads::Maybe::Mixin

  context 'mapping a block' do
    it 'maps a block over list values' do
      expect(list[1, 2, 3].fmap { |v| v + 1 }).to eql(list[2, 3, 4])
    end
  end

  context 'binding a block' do
    it 'binds a block' do
      expect(list[1, 2, 3].bind { |v| [v + 1, v + 2] }).to eql(list[2, 3, 3, 4, 4, 5])
    end
  end

  context 'getting a value' do
    let(:digits) { list[*0..9] }

    example 'get a value by index' do
      expect(digits[5]).to eql(5)
    end

    example 'index out of range' do
      expect(digits[99]).to be nil
    end

    example 'slicing' do
      expect(digits[1..2]).to eql([1, 2])
    end

    context 'safe index navigation' do
      it 'returns a value wrapped into Maybe' do
        expect(digits.get(5)).to eql(Some(5))
      end

      it 'returns None when the value is nil' do
        expect(list[nil].get(0)).to be_none
      end

      it 'returns None if an index exceeds size of a list' do
        expect(digits.get(999)).to be_none
      end
    end
  end
end
