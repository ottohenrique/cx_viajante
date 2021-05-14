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

    it 'fails when path not found' do
        nodes = <<-NODES
            A,B,10
            B,C,10
        NODES

        graph = Graph.new(nodes)

        expect(graph.paths("A","D")).to eq([])
    end

    it 'traces a basic path A-B-C' do
        nodes = <<-NODES
            A,B,10
            B,C,10
        NODES

        graph = Graph.new(nodes)

        expect(graph.paths("A","C")).to eq([["A","B","C"]])
    end

    it 'traces a A-C path passing by two nodes' do
        nodes = <<-NODES
            A,B,10
            B,C,10
            B,D,10
            D,C,10
        NODES

        graph = Graph.new(nodes)

        expect(graph.paths("A","C")).to eq([["A","B","C"], ["A","B","D","C"]])
    end

   
    it 'gives all paths from node A to B' do
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

      expect(graph.paths("GRU", "CDG")).to eq([
        ["GRU","CDG"],
        ["GRU","ORL","CDG"],
        ["GRU","SCL","ORL","CDG"],
        ["GRU","BRC","SCL","ORL","CDG"]
      ])
    end
  end
end
