# traveller

Implementação básica de um algoritmo que percorre todos os caminhos de um grafo procurando o menor custo entre os nós solicitados.

## Instalação

Faça cópia do repositório para seu ambiente

```
git clone git@github.com:ottohenrique/cx_viajante.git
```
É necessário ter o ruby instalado no ambiente (de preferência versão > 2.7) para execução do projeto.

## Testes

Instale as dependências executando o comando abaixo dentro da pasta do projeto.

```
bundle install
```

Após isso execute o `rspec` para rodar os testes que estão em `./specs`

```
bundle exec rspec
```

## Execução

### Modo console

Dentro da pasta do projeto, execute:

```
./traveller.rb config.csv
```

`config.csv` é o arquivo de configuração necessário com todos os vértices do grafo, no formato "DE,PARA,CUSTO". Colocar um vértice por linha

O programa é interativo e irá executar perguntando qual o caminho desejado no formato "DE-PARA"

### Modo web

Dentro da pasta do projeto, execute:

```
./traveller_web.rb config.csv
```

Esse comando sobe um servidor WEBRick padrão na porta 8000.

As rotas disponíveis são:

- 'GET /routes?from=X&to=Y' para buscar o caminho mais barato. Ex:

```
$ curl "localhost:8000/routes?from=gru&to=cdg"
Rota encontrada: ["GRU", "BRC", "SCL", "ORL", "CDG"], custo: 40
```

- 'POST /route' para inserir um novo vértice, ex:
```
$ curl  -X POST "localhost:8000/route" -d 'TAU,GAL,85' -v
Note: Unnecessary use of -X or --request, POST is already inferred.
*   Trying 127.0.0.1:8000...
* ...
* upload completely sent off: 10 out of 10 bytes
* Mark bundle as not supporting multiuse
< HTTP/1.1 201 Created
< Server: WEBrick/1.6.1 (Ruby/2.7.3/2021-04-05)
< Date: Tue, 18 May 2021 18:05:21 GMT
< Content-Length: 38
< Connection: Keep-Alive
< 
* Connection #0 to host localhost left intact
Rota TAU,GAL,85 adicionada com sucesso
```

## Possíveis melhorias e descobertas
- Não foi adotada nenhuma estratégia de programação dinânimca no algorítmo de busca, como excluir rotas já percorridas.
- Poderia ter usado a biblioteca básica de testes do ruby `minitest`, evitando a dependência do rspec (https://github.com/seattlerb/minitest)
