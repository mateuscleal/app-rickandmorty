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

List<SingleChildWidget> providers({String key = 'global'}) {
  final graphQLService = GraphQLService();
  final firebaseAuthService = FirebaseAuthService();
  final hiveService = HiveService(firebaseAuthService.currentUser)..init();

  final authRepository = AuthRepositoryImpl(firebaseAuthService);
  final locationRepository = LocationRepositoryImpl(graphQLService);
  final episodeRepository = EpisodeRepositoryImpl(graphQLService, hiveService);

  final mainScaffoldViewModel = MainScaffoldViewModel();
  final authViewModel = AuthViewModel()..init(authRepository);
  final episodesViewModel = EpisodesViewModel()..init(episodeRepository);
  final locationsViewModel = LocationsViewModel()..init(locationRepository);

  switch (key) {
    case 'view_models':
      return [
        ChangeNotifierProvider<MainScaffoldViewModel>.value(value: mainScaffoldViewModel),
        ChangeNotifierProvider<EpisodesViewModel>.value(value: episodesViewModel),
        ChangeNotifierProvider<LocationsViewModel>.value(value: locationsViewModel),
      ];
    default:
      return [
        Provider<GraphQLService>.value(value: graphQLService),
        Provider<FirebaseAuthService>.value(value: firebaseAuthService),
        Provider<HiveService>.value(value: hiveService),

        Provider<AuthRepositoryImpl>.value(value: authRepository),
        Provider<LocationRepositoryImpl>.value(value: locationRepository),
        Provider<EpisodeRepositoryImpl>.value(value: episodeRepository),

        ChangeNotifierProvider<AuthViewModel>.value(value: authViewModel),
      ];
  }
}
