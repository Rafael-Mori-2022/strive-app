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

// Define as rotas como enums
enum AppRoute {
  loading,
  login,
  home,
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(goRouterRefreshStreamProvider.notifier);

  // Observamos AMBOS: autenticação e o perfil do banco de dados
  final authState = ref.watch(authStateStreamProvider);
  final profileState = ref.watch(userProfileStreamProvider);

  return GoRouter(
    refreshListenable: refreshNotifier,

    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/loading',
        name: AppRoute.loading.name,
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        builder: (context, state) => const LoginScreen(),
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

      // --- NAVEGAÇÃO PRINCIPAL (COM ABAS) ---
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          // --- ABA 1: DASHBOARD ---
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
                // ROTA 'explore' REMOVIDA DAQUI
              ],
            ),
          ]),

          // --- ABA 2: DIETA ---
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

          // --- ABA 3: TREINO ---
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/workout',
              name: 'workout',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: WorkoutScreen()),
              routes: [
                GoRoute(
                  path: 'editor',
                  name: 'workout-editor',
                  pageBuilder: (context, state) =>
                      const NoTransitionPage(child: WorkoutEditorScreen()),
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
                        state.uri.queryParameters['muscle'] ?? 'Bíceps';
                    return NoTransitionPage(
                        child: AddExerciseScreen(muscleGroup: muscle));
                  },
                ),
              ],
            ),
          ]),

          // --- ABA 4: EXPLORAR ---
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
      ),

      GoRoute(
        path: '/404',
        name: 'under-construction',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: UnderConstructionScreen()),
      ),
    ],

    // Lógica de Redirecionamento
    redirect: (BuildContext context, GoRouterState state) {
      if (authState.isLoading || !authState.hasValue) {
        return '/loading';
      }

      final user = authState.valueOrNull;
      final profile = profileState.valueOrNull;

      final isLoggedIn = user != null;
      final hasProfile = profile != null;

      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToOnboarding = state.matchedLocation == '/onboarding';
      final isGoingToLoading = state.matchedLocation == '/loading';

      //Usuário deslogado
      if (!isLoggedIn) {
        return isGoingToLogin ? null : '/login';
      }

      if (isLoggedIn && !hasProfile) {
        return isGoingToOnboarding ? null : '/onboarding';
      }

      if (isLoggedIn && hasProfile) {
        if (isGoingToLogin || isGoingToLoading || isGoingToOnboarding) {
          return '/dashboard';
        }
      }

      return null;
    },

    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: UnderConstructionScreen()),
  );
});
