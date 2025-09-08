# Rick and Morty App

Este é um aplicativo Flutter desenvolvido para gerenciar informações dos episódios da série **Rick and Morty**. O app permite listar episódios, visualizar detalhes, favoritar, marcar como assistido e realizar buscas.

---

## Funcionalidades

- **Listar Episódios**  
  Exibe uma lista com o número, nome, data de exibição e a quantidade de personagens de cada episódio.

- **Detalhes do Episódio**  
  Mostra informações completas do episódio, incluindo a lista de personagens com:
    - Foto
    - Nome
    - Espécie
    - Status

- **Favoritar/Desfavoritar Episódio**  
  Adicione ou remova episódios como favoritos.

- **Marcar Episódios como Vistos**  
  Registre quais episódios já foram assistidos.

- **Buscar Episódios**  
  Permite pesquisar episódios pelo nome.

- **Lista de Favoritos**  
  Visualize rapidamente os episódios marcados como favoritos.

- **Autenticação de Usuário**  
  Login e gerenciamento de usuários utilizando **Firebase Authentication**.

---

## Tecnologias Utilizadas

- **Flutter**: Framework principal para o desenvolvimento do app.
- **Firebase Authentication**: Para gerenciar o login e autenticação dos usuários.
- **GraphQL**: Para consumo da API de dados ([Rick and Morty API](https://rickandmortyapi.com/graphql)).
- **Hive**: Para persistência local de dados como favoritos e episódios vistos.
- **Provider**: Gerenciamento de estado.

---

## Configuração e Ambiente de Desenvolvimento

Para reproduzir ou trabalhar neste projeto, é necessário ter o seguinte ambiente configurado:

- **Gradle**: Versão 8.13.0
- **Android Studio**: Narwhal 3 Feature Drop | 2025.1.3
- **Flutter**: 3.35.2
- **Dart SDK**: 3.9.0

---

## Configuração do Firebase

Para que o Firebase funcione corretamente neste projeto, é necessário **gerar os arquivos de configuração individualmente** usando o **FlutterFire CLI**. Não basta apenas adicionar o `google-services.json` ou `GoogleService-Info.plist` manualmente.

### Passos:

1. Instale o FlutterFire CLI:
```
dart pub global activate flutterfire_cli
```
2. Configure o Firebase para o projeto Flutter:
```
flutterfire configure
```
3. Isso irá gerar automaticamente os arquivos de configuração (firebase_options.dart) compatíveis com cada plataforma (Android/iOS).

4. Importe o arquivo gerado no main.dart antes de inicializar o Firebase:
```
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```