class Traveller
  def initialize(graph)
    @graph = graph
  end

  def cheapest(start, finish)
    @graph.paths(start, finish).sort_by(&:last).first
  end
end