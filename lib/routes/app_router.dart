import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskai/models/task.dart';
import 'package:taskai/screens/home_screen.dart';
import 'package:taskai/screens/profile_screen.dart';
import 'package:taskai/screens/statistics_screen.dart';
import 'package:taskai/screens/task_form_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _pageIndex(state.location),
              onDestinationSelected: (index) {
                final location = _routeForIndex(index);
                if (location != null) {
                  context.go(location);
                }
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Estadísticas',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/statistics',
            name: 'statistics',
            builder: (context, state) => const StatisticsScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/task-form',
        name: 'task-form',
        builder: (context, state) {
          final task = state.extra as Task?;
          return TaskFormScreen(task: task);
        },
      ),
    ],
  );

  static int _pageIndex(String location) {
    if (location.startsWith('/statistics')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  static String? _routeForIndex(int index) {
    switch (index) {
      case 0:
        return '/';
      case 1:
        return '/statistics';
      case 2:
        return '/profile';
      default:
        return '/';
    }
  }
}
