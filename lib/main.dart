import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/activity1_screen.dart';
import 'screens/activity2_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(
    // ChangeNotifierProvider makes a single AppState instance available
    // to every widget below it in the tree -- this is what turns
    // "Dark Mode" / "user name" into truly GLOBAL state instead of
    // something passed screen-to-screen manually.
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch rebuilds MaterialApp (and therefore re-themes the
    // ENTIRE app) the instant AppState's theme flag changes anywhere.
    final appState = context.watch<AppState>();

    return MaterialApp(
      title: 'Lab Portfolio',
      debugShowCheckedModeBanner: false,
      themeMode: appState.themeMode,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      initialRoute: '/',
      // Named routes as requested: Home + at least two Activity screens.
      routes: {
        '/': (context) => const HomeScreen(),
        '/activity1': (context) => const Activity1Screen(),
        '/activity2': (context) => const Activity2Screen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
