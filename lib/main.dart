import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskai/providers/task_provider.dart';
import 'package:taskai/providers/theme_provider.dart';
import 'package:taskai/routes/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const TaskAiApp(),
    ),
  );
}

class TaskAiApp extends StatelessWidget {
  const TaskAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskAI',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F7DF3),
        scaffoldBackgroundColor: const Color(0xFFF8F9FC),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Color(0xFFF8F9FC),
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Color(0xFF1F2937),
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F7DF3),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101827),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Color(0xFF111827),
          backgroundColor: Color(0xFF111827),
          foregroundColor: Color(0xFFFFFFFF),
          elevation: 0,
        ),
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }
}
