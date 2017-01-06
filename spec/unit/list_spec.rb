RSpec.describe(Dry::Monads::List) do
  list = described_class

  describe '#+' do
    it 'concatenates two lists' do
      expect(list[1, 2, 3] + list[4, 5, 6]).to eql(list[1, 2, 3, 4, 5, 6])
    end
  end

  describe '.coerce' do
    it 'coerces an array to a list' do
      expect(list.coerce([1, 2, 3])).to eql(list.new([1, 2, 3]))
    end

    it 'returns a list back' do
      l = list[1, 2, 3]
      expect(list.coerce(l)).to be(l)
    end

    it 'returns an empty list for nil' do
      expect(list.coerce(nil)).to eql list[]
    end
  end

  describe '.[]' do
    it 'is a list constructor' do
      l = list[1, 2, 3]
      expect(l).to be_a(list)
      expect(l).to eql(list.new([1, 2, 3]))
    end

    it 'it returns an empty list if no arguments provided' do
      expect(list[]).to eql(list.new([]))
    end
  end

  describe '#value' do
    it 'returns the internal array value' do
      expect(list[1, 2, 3].value).to eql([1, 2, 3])
    end
  end
end
