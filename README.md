# Rick and Morty App

Este é um aplicativo Flutter desenvolvido para gerenciar informações dos episódios da série **Rick and Morty**. O app permite listar episódios, visualizar detalhes, favoritar, marcar como assistido e realizar buscas.

---

## Funcionalidades

- **Listar Episódios**
    - Exibe uma lista com o número, nome, data de exibição e a quantidade de personagens de cada episódio.

- **Detalhes do Episódio**
    - Mostra informações completas do episódio, incluindo a lista de personagens com:
        - Foto
        - Nome
        - Espécie
        - Status

- **Favoritar/Desfavoritar Episódio**
    - Adicione ou remova episódios como favoritos.

- **Marcar Episódios como Vistos**
    - Registre quais episódios já foram assistidos.

- **Buscar Episódios**
    - Permite pesquisar episódios pelo nome.

- **Lista de Favoritos**
    - Visualize rapidamente os episódios marcados como favoritos.

---

## Tecnologias Utilizadas

- **Flutter**: Framework principal para o desenvolvimento do app.
- **GraphQL**: Para consumo da API de dados (https://rickandmortyapi.com/graphql).
- **Hive**: Para persistência local de dados como favoritos e episódios vistos.
- **Provider**: Gerenciamento de estado.

---

## Configuração e Ambiente de Desenvolvimento

Para reproduzir ou trabalhar neste projeto, é necessário ter o seguinte ambiente configurado:

- **Gradle**: Versão 8.12.2.
- **Android Studio**: Narwhal Feature Drop | 2025.1.2 Patch 2
- **Flutter**: Versão utilizada no projeto, **3.32.5**
- **Dart SDK**: Versão utilizada no projeto, **3.8.1**