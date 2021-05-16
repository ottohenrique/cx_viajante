require File.join(RSPEC_ROOT, '../src/lib/traveller.rb')
require File.join(RSPEC_ROOT, '../src/lib/graph.rb')

RSpec.describe Traveller do
  describe '#cheapest' do
    it 'returns the cheapest path from options' do
      nodes_csv = <<-NODES
      A,B,10
      B,C,20
      B,D,10
      D,C,20
      NODES

      graph = Graph.new(nodes_csv)
      traveller = Traveller.new(graph)

      expect(traveller.cheapest('A', 'C')).to eq(['A', 'B', 'C', 30])
    end

    it 'returns cheapest path from a big graph' do
      nodes = <<-NODES
            GRU,CDG,75
            GRU,ORL,56
            ORL,CDG,5
            GRU,BRC,10
            BRC,SCL,5
            GRU,SCL,20
            SCL,ORL,20
      NODES

      graph = Graph.new(nodes)
      traveller = Traveller.new(graph)

      expect(traveller.cheapest('GRU', 'CDG')).to eq(['GRU', 'BRC', 'SCL', 'ORL', 'CDG', 40])
    end
  end
end
