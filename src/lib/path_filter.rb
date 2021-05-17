class PathFilter
  def initialize(paths)
    @paths = paths
  end

  def cheapest
    @paths.sort_by(&:last).first
  end
end