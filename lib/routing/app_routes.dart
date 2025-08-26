import 'package:app/ui/home_episodes/widgets/episode_details_screen.dart';
import 'package:app/ui/locations/widgets/locations_residents_screen.dart';
import 'package:app/ui/main_scaffold/widgets/main_scaffold_screen.dart';
import 'package:app/ui/splash/widgets/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/splash_screen';
  static const String mainScaffold = '/main_scaffold';
  static const String episodeDetails = '/episode_details_screen';
  static const String locationsResidents = '/locations_residents_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    episodeDetails: (_) => const EpisodeDetailsScreen(),
    locationsResidents: (_) => const LocationsResidentsScreen(),
    mainScaffold: (_) => MainScaffoldScreen(),
  };
}
