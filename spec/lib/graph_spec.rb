require File.join(RSPEC_ROOT, '../src/lib/graph.rb')

RSpec.describe Graph do
  describe '#initialize' do
    it 'creates a new graph with given nodes' do
      nodes = <<-NODES
            GRU,BRC,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.nodes).to eq(%w[BRC GRU])
    end

    it 'keeps only one node by name' do
      nodes = <<-NODES
            GRU,BRC,10
            GRU,XDU,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.nodes).to eq(%w[BRC GRU XDU])
    end
  end

  describe '#paths' do
    it 'returns empty array when no route is found' do
      nodes = <<-NODES
            A,B,10
            B,C,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.paths('A', 'D')).to eq([])
      expect(graph.paths('X', 'Z')).to eq([])
    end

    it 'traces a basic path A-B-C' do
      nodes = <<-NODES
            A,B,10
            B,C,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.paths('A', 'C')).to eq([['A', 'B', 'C', 20]])
    end

    it 'traces a A-C path passing by two nodes' do
      nodes = <<-NODES
            A,B,10
            B,C,10
            B,D,10
            D,C,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.paths('A', 'C')).to eq([['A', 'B', 'C', 20], ['A', 'B', 'D', 'C', 30]])
    end

    it 'traces all possible paths from node A to B' do
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

      expect(graph.paths('GRU', 'CDG')).to eq([
                                                ["GRU", "CDG", 75],
                                                ["GRU", "ORL", "CDG", 61],
                                                ["GRU", "SCL", "ORL", "CDG", 45],
                                                ["GRU", "BRC", "SCL", "ORL", "CDG", 40]
                                              ])
    end

    it 'calculates cost by path' do
      nodes = <<-NODES
      A,B,10
      B,C,10
      NODES

      graph = Graph.new(nodes)

      expect(graph.paths('A', 'C')).to eq([['A', 'B', 'C', 20]])
    end
  end
end
