class Graph
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

  def nodes
    @nodes.keys.sort
  end

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
