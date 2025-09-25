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

## Arquitetura do Projeto (_Clean Architecture + MVVM + Provider e ChangeNotifier_)

- **UI**          → Exibe dados / reage a eventos
- **ViewModel**   → Mantém estado / chama Use Cases
- **UseCase**     → Regra de negócio específica
- **Repository**  → Abstrai acesso a dados (Camada única)
- **Service**     → Chama API / DB (Camada suja)
- **Domain**      → Modelos puros de domínio
- **Data/model**  → Modelos de API (DTOs)

```plaintext
lib
├── config
│   └── dependencies.dart
├── data
│   ├── graphql
│   │   └── graphql_queries.dart
│   ├── model
│   │   ├── episode_dto.dart
│   │   ├── location_dto.dart
│   │   ├── resident_dto.dart
│   │   └── user_dto.dart
│   ├── repositories
│   │   ├── authentication
│   │   │   ├── auth_repository.dart
│   │   │   └── auth_repository_impl.dart
│   │   ├── episode
│   │   │   ├── episode_repository.dart
│   │   │   └── episode_repository_impl.dart
│   │   └── location
│   │       ├── location_repository.dart
│   │       └── location_repository_impl.dart
│   └── services
│       ├── firebase_auth_service.dart
│       ├── graphql_service.dart
│       └── hive_service.dart
├── domain
│   ├── models
│   │   ├── episode.dart
│   │   ├── location.dart
│   │   ├── resident.dart
│   │   └── user.dart
│   └── use_cases
│       ├── auth
│       │   ├── auth_usecases.dart
│       │   ├── check_email_verified.dart
│       │   ├── check_if_email_exists.dart
│       │   ├── send_email_verification.dart
│       │   ├── send_password_reset_email.dart
│       │   ├── sign_in.dart
│       │   ├── sign_out.dart
│       │   └── sign_up.dart
│       ├── episodes
│       │   ├── episodes_usecases.dart
│       │   ├── get_all_episodes.dart
│       │   ├── get_favorite_episodes.dart
│       │   ├── search_episodes.dart
│       │   ├── toggle_favorite_episode.dart
│       │   └── toggle_watched_episode.dart
│       └── locations
│           ├── get_all_locations.dart
│           └── locations_usecases.dart
├── firebase_options.dart
├── main.dart
├── routing
│   └── app_routes.dart
└── ui
    ├── _core
    │   ├── theme
    │   │   ├── app_colors.dart
    │   │   └── app_theme.dart
    │   ├── view_models
    │   │   └── episodes_view_model.dart
    │   └── widgets
    │       ├── show_dialogs
    │       │   ├── show_dialog_logout.dart
    │       │   └── show_dialog_password_reset.dart
    │       └── show_snack_bar
    │           ├── authentication_password_reset.dart
    │           └── authentication_sign_in.dart
    ├── authentication
    │   ├── view_model
    │   │   └── auth_view_model.dart
    │   ├── views
    │   │   ├── authentication_screen.dart
    │   │   └── email_sent_screen.dart
    │   └── widgets
    │       ├── sign_in.dart
    │       ├── sign_up.dart
    │       └── step_item_widget.dart
    ├── episodes
    │   ├── views
    │   │   ├── episode_details_screen.dart
    │   │   └── episodes_screen.dart
    │   └── widgets
    │       ├── character_card.dart
    │       └── episode_card.dart
    ├── favorites
    │   ├── views
    │   │   └── favorites_screen.dart
    │   └── widgets
    │       └── simple_episode_card.dart
    ├── locations
    │   ├── view_models
    │   │   └── locations_view_model.dart
    │   ├── views
    │   │   ├── locations_residents_screen.dart
    │   │   └── locations_screen.dart
    │   └── widgets
    │       ├── location_card.dart
    │       └── residents_card.dart
    ├── main_scaffold
    │   ├── view_models
    │   │   └── main_scaffold_view_model.dart
    │   ├── views
    │   │   └── main_scaffold_screen.dart
    │   └── widgets
    │       ├── app_bar_custom.dart
    │       └── bottom_nav_bar_items.dart
    └── splash
        └── views
            └── splash_screen.dart

```

---

## Configuração e Ambiente de Desenvolvimento

Para reproduzir ou trabalhar neste projeto, é necessário ter o seguinte ambiente configurado:

- **Gradle**: Versão 8.13.0
- **Android Studio**: Narwhal 3 Feature Drop | 2025.1.3
- **Flutter**: 3.35.2
- **Dart SDK**: 3.9.0

## Como Rodar o Projeto

```bash
# 1. Clone o repositório
git clone https://github.com/mateuscleal/app-rickandmorty.git

# 2. Acesse a pasta do projeto
cd app-rickandmorty

# 3. Instale as dependências
flutter pub get

# 4. Rode o projeto
flutter run
```

---

## Configurar Firebase (FlutterFire CLI)

### 1. Instalar Firebase CLI
```bash
npm install -g firebase-tools
firebase login
```

### 2. Instalar FlutterFire CLI
```bash
dart pub global activate flutterfire_cli
```

> Se precisar, adicione ao PATH:
> - macOS/Linux: export PATH="$PATH:$HOME/.pub-cache/bin"
> - Windows: %USERPROFILE%\AppData\Local\Pub\Cache\bin

### 3. Configurar no projeto
Na raiz do projeto:
```bash
flutterfire configure
```

Selecione seu projeto do Firebase e as plataformas (Android/iOS/Web). O CLI gera automaticamente `lib/firebase_options.dart` e adiciona os arquivos `google-services.json`/`GoogleService-Info.plist`.


### 4. Inicializar Firebase no main.dart

```dart

/// Exemplo:

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      home: Scaffold(body: Center(child: Text('Hello Firebase'))),
    );
  }
}
```

---

## Habilitar Login com E-mail/Senha no Firebase

1. Acesse [https://console.firebase.google.com](https://console.firebase.google.com)
2. Selecione seu projeto.
3. Vá em **Authentication** > **Método de login**.
4. Clique em **E-mail/senha**.
5. Ative a opção **Habilitar** e clique em **Salvar**.

Pronto: seu app já poderá autenticar usuários com `createUserWithEmailAndPassword` e `signInWithEmailAndPassword`.

---
