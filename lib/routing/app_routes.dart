import 'package:app/ui/authentication/views/authentication_screen.dart';
import 'package:app/ui/episodes/views/episode_details_screen.dart';
import 'package:app/ui/locations/views/locations_residents_screen.dart';
import 'package:app/ui/main_scaffold/views/main_scaffold_screen.dart';
import 'package:app/ui/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/dependencies.dart';
import '../ui/authentication/views/email_sent_screen.dart';

class AppRoutes {
  static const String splash = '/splash_screen';
  static const String authentication = '/authentication_screen';
  static const String verifyEmail = '/verify_email_screen';
  static const String mainScaffold = '/main_scaffold';
  static const String episodeDetails = '/episode_details_screen';
  static const String locationsResidents = '/locations_residents_screen';

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    authentication: (_) => const AuthenticationScreen(),
    verifyEmail: (_) => EmailSentScreen(),
    episodeDetails: (_) => const EpisodeDetailsScreen(),
    locationsResidents: (_) => const LocationsResidentsScreen(),
    mainScaffold: (_) => MultiProvider(
      providers: providers(key: 'view_models'),
      child: const MainScaffoldScreen(),
    ),
  };
}
