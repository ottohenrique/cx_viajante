class Graph
  # salva os nós em um mapa usando o nome como chave e o custo como valor
  # ex:
  #   Graph.new(<<-NODES
  #     A,B,10
  #     B,c,20
  #     NODES)
  #
  #  {
  #    a: {b: 10}
  #    b: {a: 10, c: 20}
  #    c: {b: 20}
  #  }
  def initialize(nodes)
    @nodes = {}

    nodes.split("\n").each do |path|
      a, b, delta = path.split(',').map { |k| k.strip }

      @nodes[a] = @nodes[a] || {}
      @nodes[a][b] = delta.to_i

      @nodes[b] = @nodes[b] || {}
      @nodes[b][a] = delta.to_i
    end
  end

  # retorna todos os nós existentes no grafo
  def nodes
    @nodes.keys.sort
  end

  # procura recursivamente todos os caminhos possíveis entre A e B
  # retornando um array com todos os nós no caminho e o custo da jornada como
  # último elemento.
  def paths(start, finish)
    trace(start, finish, [], 0).sort_by(&:size)
  end

  private

  def trace(node, finish, path, cost)
    return [] if @nodes[node].nil?

    (@nodes[node].keys - path).map do |child|
      local_cost = @nodes[node][child]

      if child == finish
        [path + [node, child, cost + local_cost]]
      else
        trace(child, finish, path + [node], cost + local_cost)
      end
    end.reject(&:empty?).flatten(1)
  end
end
