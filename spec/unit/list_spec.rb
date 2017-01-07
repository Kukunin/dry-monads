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

  describe '#to_a' do
    it 'coerces to an array' do
      arr = [1, 2, 3]
      expect(list.new(arr).to_a).to eql([1, 2, 3])
      expect(list.new(arr).to_a).not_to be(arr)
    end
  end

  describe '#foldl' do
    it 'folds the list' do
      expect(list[1, 2, 3].foldl(0) { |acc, i| acc + i }).to eql(6)
    end

    it 'folds the list from the left' do
      expect(list[3, 4].foldl(2) { |acc, i| acc ** i }).to eql(4096)
    end
  end

  describe '#reduce' do
    it 'is an alias for #foldl' do
      expect(list[3, 4].reduce(2) { |acc, i| acc ** i }).to eql(4096)
    end
  end

  describe '#inject' do
    it 'is an alias for #foldl' do
      expect(list[3, 4].inject(2) { |acc, i| acc ** i }).to eql(4096)
    end
  end

  describe '#foldr' do
    it 'folds the list' do
      expect(list[1, 2, 3].foldr(0) { |acc, i| acc + i }).to eql(6)
    end

    it 'folds the list from the right' do
      expect(list[3, 4].foldr(2) { |acc, i| acc ** i }).to eql(43046721)
    end
  end

  describe '#inspect' do
    it 'returns a string representation' do
      expect(list[1, 2, 3].inspect).to eql('List[1, 2, 3]')
    end
  end

  describe '#to_s' do
    it 'is an alias for #inspect' do
      expect(list[1, 2, 3].to_s).to eql('List[1, 2, 3]')
    end
  end

  describe '#filter' do
    it 'filters list values with a predicate' do
      expect(list[1, 2, 3].filter { |x| x % 2 == 1 }).to eql(list[1, 3])
    end
  end

  describe '#select' do
    it 'is an alias for #filter' do
      expect(list[1, 2, 3].select { |x| x % 2 == 1 }).to eql(list[1, 3])
    end
  end
end
