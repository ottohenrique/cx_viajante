require File.join(ROOT_DIR, './src/lib/graph.rb')
require File.join(ROOT_DIR, './src/lib/path_filter.rb')

class App
  def initialize(nodes)
    @graph = Graph.new(nodes)
  end

  def run
    looking = true
    puts 'CX_Viajante agência de viagens: (SAIR ou Ctrl+C para terminar)'

    while looking
      puts 'Informe a rota para pesquisar no formato PARTIDA-CHEGADA ou ROTAS para lista de destinos:'

      cmd = gets.chomp.upcase

      case cmd
      when 'ROTAS'
        puts 'Rotas: '
        puts @graph.nodes.map { |node| '  ' + node }
      when 'SAIR'
        exit(0)
      else
        start, finish = cmd.split('-')
        puts cheapest_route(start, finish)
      end
    end
  end

  def cheapest_route(from, to)
    paths = @graph.paths(from.upcase, to.upcase)

    return "Nenhuma rota encontrada para #{from}-#{to}..." if paths.empty?

    cheapest = PathFilter.new(paths).cheapest

    cost = cheapest.pop
    
    "Rota encontrada: #{cheapest}, custo: #{cost}"
  end
end
