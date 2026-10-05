import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/custom_card.dart';
import 'activity1_screen.dart';
import 'activity2_screen.dart';
import 'settings_screen.dart';

/// HomeScreen is the dashboard / menu. It is a StatelessWidget itself --
/// its only "state" (theme + username) lives globally in AppState and is
/// read here via Consumer, so it always reflects the latest values without
/// HomeScreen needing to manage anything locally.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Portfolio Dashboard'),
        actions: [
          // Quick dark/light toggle right in the app bar, driven by
          // global AppState. Toggling it instantly updates the whole app.
          Consumer<AppState>(
            builder: (context, appState, _) => IconButton(
              tooltip: 'Toggle theme',
              icon: Icon(
                appState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: appState.toggleTheme,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---- Greeting header, reactive to global userName ----
              Consumer<AppState>(
                builder: (context, appState, _) => Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        appState.userName.isNotEmpty
                            ? appState.userName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Expanded prevents overflow if the name is long.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back,',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            appState.userName,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Chip(
                      label: Text(
                          '${appState.activitiesCompleted} done'),
                      avatar: const Icon(Icons.check_circle, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Activities', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              // ---- Responsive grid of activity menu cards ----
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Adapts column count to available width so the
                    // dashboard works on phones, tablets, and desktop.
                    final crossAxisCount =
                        constraints.maxWidth ~/ 180 < 2
                            ? 2
                            : constraints.maxWidth ~/ 180;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.95,
                      children: [
                        ActivityCard(
                          title: 'Activity 1',
                          subtitle: 'Counter Lab (local state)',
                          icon: Icons.exposure_plus_1,
                          color: Colors.indigo,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Activity1Screen()),
                          ),
                        ),
                        ActivityCard(
                          title: 'Activity 2',
                          subtitle: 'Notes Lab (local state)',
                          icon: Icons.note_alt_outlined,
                          color: Colors.teal,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Activity2Screen()),
                          ),
                        ),
                        ActivityCard(
                          title: 'Settings',
                          subtitle: 'Theme & profile (global state)',
                          icon: Icons.settings,
                          color: Colors.deepOrange,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SettingsScreen()),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
