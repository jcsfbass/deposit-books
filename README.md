[![Stories in Ready](https://badge.waffle.io/jcsfbass/deposit-books.svg?label=ready&title=A%20Fazer)](https://waffle.io/jcsfbass/deposit-books)
[![Stories in Progress](https://badge.waffle.io/jcsfbass/deposit-books.svg?label=In%20Progress&title=Fazendo)](https://waffle.io/jcsfbass/deposit-books)
# Depósito de livros


## Sobre

Esta aplicação foi criada para estudos de Ruby, Rest API e Sinatra.


## Requisitos


### Ruby

- Você pode baixar via RVM: https://rvm.io


## Desenvolvimento

Os seguintes procedimentos descrevem como testar e desenvolver a aplicação


### Instalando dependências

A aplicação requer que esteja instalado algumas dependências. Você pode instalar executando:

```
bundle install
```

### Executando a aplicação durante o desenvolvimento

- Execute `rake start`
- Acesse no sua ferramenta cliente HTTP e faça a requisição `GET http://localhost:4567/livros` para ver a aplicação funcionando.


### Executando testes

- Para testes unitários: `rake test:unit`
- Para testes de API: `rake test:api`
- Para todos os testes: `rake test:all`
