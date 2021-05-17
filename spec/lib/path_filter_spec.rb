require File.join(RSPEC_ROOT, '../src/lib/path_filter.rb')
require File.join(RSPEC_ROOT, '../src/lib/graph.rb')

RSpec.describe PathFilter do
  describe '#cheapest' do
    it 'returns the cheapest from a list of paths' do
      paths = [
        ['A', 'B', 'C', 40],
        ['A', 'C', 60],
        ['A', 'B', 'C', 'D', 10]
      ]

      expect(PathFilter.new(paths).cheapest).to eq(['A', 'B', 'C', 'D', 10])
    end
  end
end
