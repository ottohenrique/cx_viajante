require File.join(ROOT_DIR, './src/lib/graph.rb')

class App
  def initialize(nodes)
    @graph = Graph.new(nodes)
  end

  def run
    looking = true
    puts 'CX_Viajante agência de viagens: (0 para sair, ? para comandos)'

    while looking
      puts 'Informe a rota para pesquisar no formato PARTIDA-CHEGADA ou ROTAS para lista de destinos:'

      cmd = ''

      puts @graph.nodes if cmd == 'ROTAS'
    end
  end
end
