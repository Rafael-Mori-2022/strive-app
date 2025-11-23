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

enum AppRoute {
  loading,
  login,
  home,
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(goRouterRefreshStreamProvider.notifier);

  // Observamos os estados
  final authState = ref.watch(authStateStreamProvider);
  final profileState = ref.watch(userProfileStreamProvider.select(
  (value) => value.whenData((profile) => profile != null)
  ));

  return GoRouter(
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
                // Rota do Editor (Agora recebe o ID do plano na URL)
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
                // Rota de Adicionar Exercício (Captura muscle e planId)
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

    // --- LÓGICA DE REDIRECIONAMENTO BLINDADA ---
    redirect: (BuildContext context, GoRouterState state) {
      
      final isLoggingIn = state.matchedLocation == '/login';
      final isOnboarding = state.matchedLocation == '/onboarding';
      final isLoading = state.matchedLocation == '/loading';

      // 1. Auth Loading -> Loading (Prioridade Máxima)
      if (authState.isLoading) return '/loading';

      final isLoggedIn = authState.valueOrNull != null;

      // 2. Não Logado -> Login
      if (!isLoggedIn) {
        return isLoggingIn ? null : '/login';
      }

      // 3. Perfil Loading -> Loading (Prioridade Alta para evitar flash de onboarding)
      if (profileState.isLoading) return '/loading';

      final hasProfile = profileState.valueOrNull != null;

      // 4. Logado mas SEM Perfil -> Onboarding
      // Se ele tentar sair do onboarding, forçamos ele a ficar
      if (!hasProfile) {
        return isOnboarding ? null : '/onboarding';
      }

      // 5. Logado E COM Perfil (Caso Crítico)
      if (hasProfile) {
        // Se ele tentar ir para Login, Loading ou Onboarding, mandamos para Dashboard.
        // CASO CONTRÁRIO (ex: ele está em /diet), deixamos ele quieto (return null).
        if (isLoggingIn || isLoading || isOnboarding) {
          return '/dashboard';
        }
      }

      // Nenhuma regra de bloqueio se aplica -> Deixa navegar
      return null;
    },

    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: UnderConstructionScreen()),
  );
});