import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

/// SettingsScreen is where the GLOBAL parameters live: dark/light theme
/// and the user's profile name. Every change here calls a method on the
/// shared AppState, which calls notifyListeners() -- and because
/// HomeScreen (and the AppBar toggle) both listen via Consumer, they
/// update instantly, even though this is a completely different screen.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // A local controller is fine here (it's just for editing convenience);
  // the actual source of truth remains the global AppState.
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: context.read<AppState>().userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Display name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<AppState>()
                        .updateUserName(_nameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Name updated globally!')),
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            const Divider(height: 40),
            Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),

            // Consumer here rebuilds ONLY this switch tile when theme
            // changes -- the rest of the screen doesn't need to.
            Consumer<AppState>(
              builder: (context, appState, _) => SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Dark Mode'),
                subtitle: const Text(
                    'Updates the whole app instantly, including the Home Dashboard.'),
                secondary: Icon(
                  appState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                value: appState.isDarkMode,
                onChanged: appState.setDarkMode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
