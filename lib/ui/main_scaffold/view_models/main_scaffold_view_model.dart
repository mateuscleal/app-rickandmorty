import 'package:app/ui/favorites/widgets/favorites_screen.dart';
import 'package:app/ui/home_episodes/widgets/episodes_screen.dart';
import 'package:app/ui/locations/widgets/locations_screen.dart';
import 'package:flutter/material.dart';

class MainScaffoldViewModel extends ChangeNotifier {
  int _currentIndex = 1;
  bool _isExpanded = false;
  final List<String> titles = [
    'assets/images/logo_rm_discover.png',
    'assets/images/logo_rm_home.png',
    'assets/images/logo_rm_favorites.png',
  ];

  final List<Widget> _views = [LocationsScreen(), EpisodesScreen(), FavoritesScreen()];

  bool get isExpanded => _isExpanded;

  int get currentIndex => _currentIndex;

  Widget get currentView => _views[_currentIndex];

  void getIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleSearch() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
