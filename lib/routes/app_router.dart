import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/providers/auth_providers.dart';
import 'package:strive/presentation/shell/app_shell.dart';
import 'package:strive/presentation/screens/onboarding/profile_setup_screen.dart';
import 'package:strive/presentation/screens/common/success_screen.dart';
import 'package:strive/presentation/screens/dashboard/home_dashboard_screen.dart';
import 'package:strive/presentation/screens/diet/diet_screen.dart';
import 'package:strive/presentation/screens/diet/add_food_screen.dart';
import 'package:strive/presentation/screens/diet/meal_detail_screen.dart';
import 'package:strive/presentation/screens/workout/workout_screen.dart';
import 'package:strive/presentation/screens/workout/workout_editor_screen.dart';
import 'package:strive/presentation/screens/workout/workout_create_screen.dart';
import 'package:strive/presentation/screens/workout/add_exercise_screen.dart';
import 'package:strive/presentation/screens/gamification/leaderboard_screen.dart';
import 'package:strive/presentation/screens/explore/explore_screen.dart';
import 'package:strive/presentation/screens/config/edit_stats_screen.dart';
import 'package:strive/presentation/screens/common/under_construction_screen.dart';
import 'package:strive/presentation/screens/profile/profile_screen.dart';
import 'package:strive/presentation/screens/basic/login_screen.dart';
import 'package:strive/presentation/screens/basic/loading_screen.dart';
import 'package:strive/presentation/screens/profile/profile_providers.dart';
import 'package:strive/presentation/state/navigation_provider.dart';

enum AppRoute {
  loading,
  login,
  home,
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(goRouterRefreshStreamProvider.notifier);

  final authState = ref.watch(authStateStreamProvider);
  
  final lastRoute = ref.read(navigationStateProvider);

  final profileState = ref.watch(userProfileStreamProvider.select(
    (value) => value.whenData((profile) => profile != null),
  ));
  final isProfileLoading = ref.watch(
    userProfileStreamProvider.select((value) => value.isLoading),
  );

  final router = GoRouter(
    refreshListenable: refreshNotifier,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/loading',
        name: AppRoute.loading.name,
        pageBuilder: (context, state) => const NoTransitionPage(child: LoadingScreen()),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        pageBuilder: (context, state) => const NoTransitionPage(child: LoginScreen()),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfileSetupScreen()),
      ),
      GoRoute(
        path: '/success',
        name: 'success',
        pageBuilder: (context, state) => const NoTransitionPage(
            child: SuccessScreen(
                message: 'Tudo Certo! Seus dados foram cadastrados!')),
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/dashboard',
              name: 'dashboard',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomeDashboardScreen()),
              routes: [
                GoRoute(
                  path: 'leaderboard',
                  name: 'leaderboard',
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: LeaderboardScreen()),
                ),
                GoRoute(
                  path: 'edit-stats',
                  name: 'edit-stats',
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: EditStatsScreen()),
                ),
              ],
            ),
          ]),

          StatefulShellBranch(routes: [
            GoRoute(
              path: '/diet',
              name: 'diet',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: DietScreen()),
              routes: [
                GoRoute(
                  path: 'add-food',
                  name: 'add-food',
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: AddFoodScreen()),
                ),
                GoRoute(
                  path: 'meal/:id',
                  name: 'meal-detail',
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return NoTransitionPage(
                        child: MealDetailScreen(mealId: id));
                  },
                ),
              ],
            ),
          ]),

          StatefulShellBranch(routes: [
            GoRoute(
              path: '/workout',
              name: 'workout',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: WorkoutScreen()),
              routes: [
                // Rota do Editor
                GoRoute(
                  path: 'editor/:planId', 
                  name: 'workout-editor',
                  pageBuilder: (context, state) {
                    final planId = state.pathParameters['planId']!;
                    return NoTransitionPage(
                        child: WorkoutEditorScreen(planId: planId));
                  },
                ),
                GoRoute(
                  path: 'create',
                  name: 'workout-create',
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: WorkoutCreateScreen()),
                ),
                GoRoute(
                  path: 'add-exercise',
                  name: 'add-exercise',
                  pageBuilder: (context, state) {
                    final muscle =
                        state.uri.queryParameters['muscle'] ?? 'Peito';
                    final planId = 
                        state.uri.queryParameters['planId'] ?? '';
                    return NoTransitionPage(
                        child: AddExerciseScreen(muscleGroup: muscle, planId: planId));
                  },
                ),
              ],
            ),
          ]),

          StatefulShellBranch(routes: [
            GoRoute(
              path: '/explore',
              name: 'explore',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ExploreScreen()),
            ),
          ]),
        ],
      ),

      GoRoute(
        path: '/profile',
        name: 'profile',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfileScreen()),
        routes: [
          GoRoute(
            path: 'edit',
            name: 'edit-profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileSetupScreen()),
          ),
        ],
      ),

      GoRoute(
        path: '/404',
        name: 'under-construction',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: UnderConstructionScreen()),
      ),
    ],

    redirect: (BuildContext context, GoRouterState state) {
      
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isLoading = state.matchedLocation == '/loading';

      // 1. Auth Loading -> Loading
      if (authState.isLoading) return '/loading';

      final isLoggedIn = authState.valueOrNull != null;

      if (!isLoggedIn) {
        return isLoggingIn ? null : '/login';
      }

      if (isProfileLoading) return '/loading';

      final hasProfile = profileState.value ?? false;

      if (!hasProfile) {
        return isOnboarding ? null : '/onboarding';
      }

      if (isLoggingIn || isLoading || isOnboarding) {
        if (lastRoute != null && lastRoute.isNotEmpty && lastRoute != '/') {
           return lastRoute;
        }
        return '/dashboard';
      }

      return null;
    },

    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: UnderConstructionScreen()),
  );

  router.routerDelegate.addListener(() {
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    
    Future.microtask(() {
      ref.read(navigationStateProvider.notifier).saveLastRoute(location);
    });
  });

  return router;
});