import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vigorbloom/presentation/shell/app_shell.dart';
import 'package:vigorbloom/presentation/screens/onboarding/profile_setup_screen.dart';
import 'package:vigorbloom/presentation/screens/common/success_screen.dart';
import 'package:vigorbloom/presentation/screens/dashboard/home_dashboard_screen.dart';
import 'package:vigorbloom/presentation/screens/diet/diet_screen.dart';
import 'package:vigorbloom/presentation/screens/diet/add_food_screen.dart';
import 'package:vigorbloom/presentation/screens/diet/meal_detail_screen.dart';
import 'package:vigorbloom/presentation/screens/workout/workout_screen.dart';
import 'package:vigorbloom/presentation/screens/workout/workout_editor_screen.dart';
import 'package:vigorbloom/presentation/screens/workout/workout_create_screen.dart';
import 'package:vigorbloom/presentation/screens/workout/add_exercise_screen.dart';
import 'package:vigorbloom/presentation/screens/gamification/leaderboard_screen.dart';
import 'package:vigorbloom/presentation/screens/explore/explore_screen.dart';
import 'package:vigorbloom/presentation/screens/config/edit_stats_screen.dart';
import 'package:vigorbloom/presentation/screens/common/under_construction_screen.dart';
import 'package:vigorbloom/presentation/screens/profile/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/dashboard',
    routes: [
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

          // --- ABA 4: EXPLORAR (CORRIGIDO) ---
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
    errorPageBuilder: (context, state) =>
        const NoTransitionPage(child: UnderConstructionScreen()),
  );
});
