import 'package:app/data/services/firebase_auth_service.dart';
import 'package:app/ui/_core/view_models/episodes_view_model.dart';
import 'package:app/ui/main_scaffold/view_models/main_scaffold_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/authentication/auth_repository_impl.dart';
import '../data/repositories/episode/episode_repository_impl.dart';
import '../data/repositories/location/location_repository_impl.dart';
import '../data/services/graphql_service.dart';
import '../data/services/hive_service.dart';
import '../ui/authentication/view_model/auth_view_model.dart';
import '../ui/locations/view_models/locations_view_model.dart';

List<SingleChildWidget> providers = [
  /// Singleton providers for services
  Provider<GraphQLService>(create: (_) => GraphQLService()),
  Provider<HiveManager>(create: (_) => HiveManager()),
  Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),

  /// Proxy providers for repositories
  ProxyProvider<FirebaseAuthService, AuthRepositoryImpl>(update: (context, auth, _) => AuthRepositoryImpl(auth)),
  ProxyProvider<GraphQLService, LocationRepositoryImpl>(
    update: (context, graphql, _) => LocationRepositoryImpl(graphql),
  ),
  ProxyProvider2<GraphQLService, HiveManager, EpisodeRepositoryImpl>(
    update: (context, graphql, hive, _) => EpisodeRepositoryImpl(graphql, hive),
  ),

  /// Change notifiers for view models
  ChangeNotifierProvider(create: (_) => MainScaffoldViewModel()),
  ChangeNotifierProxyProvider<AuthRepositoryImpl, AuthViewModel>(
    create: (_) => AuthViewModel(),
    update: (_, repo, viewModel) => viewModel!..init(repo),
  ),
  ChangeNotifierProxyProvider<EpisodeRepositoryImpl, EpisodesViewModel>(
    create: (_) => EpisodesViewModel(),
    update: (_, repo, viewModel) => viewModel!..init(repo),
  ),
  ChangeNotifierProxyProvider<LocationRepositoryImpl, LocationsViewModel>(
    create: (_) => LocationsViewModel(),
    update: (_, repo, viewModel) => viewModel!..init(repo),
  ),
];
