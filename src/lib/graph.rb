class Graph
  def initialize(nodes)
    @nodes = {}

    nodes.split("\n").each do |path|
      a, b, delta = path.split(',').map { |k| k.strip }

      @nodes[a] = @nodes[a] || {}
      @nodes[a][b] = delta

      @nodes[b] = @nodes[b] || {}
      @nodes[b][a] = delta
    end
  end

  def nodes
    @nodes.keys.sort
  end

  def paths(start, finish)
    trace(start, finish, []).sort_by(&:size)
  end

  private

  def trace(node, finish, path)
    (@nodes[node].keys - path).map do |child|
      if child == finish
        [path + [node, child]]
      else
        trace(child, finish, path + [node])
      end
    end.reject(&:empty?).flatten(1)
  end
end
