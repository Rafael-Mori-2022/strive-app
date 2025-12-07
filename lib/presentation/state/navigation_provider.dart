import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:strive/providers/locale_provider.dart'; 

class NavigationStateNotifier extends Notifier<String?> {
  static const String _kLastRouteKey = 'last_visited_route';

  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getString(_kLastRouteKey);
  }

  void saveLastRoute(String location) {
    if (location == '/login' || 
        location == '/loading' || 
        location == '/onboarding' ||
        location == '/success') {
      return;
    }

    state = location;
    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setString(_kLastRouteKey, location);
  }
}

final navigationStateProvider = NotifierProvider<NavigationStateNotifier, String?>(() {
  return NavigationStateNotifier();
});