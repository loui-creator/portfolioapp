import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../widgets/custom_button.dart';

/// Activity1Screen is a StatefulWidget because it needs a mutable value
/// (the counter) that only matters to THIS screen and should trigger a
/// local rebuild -- a textbook example contrasted with the global
/// AppState used elsewhere in the app.
class Activity1Screen extends StatefulWidget {
  const Activity1Screen({super.key});

  @override
  State<Activity1Screen> createState() => _Activity1ScreenState();
}

class _Activity1ScreenState extends State<Activity1Screen> {
  int _counter = 0; // local, screen-specific state

  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() {
        if (_counter > 0) _counter--;
      });
  void _reset() => setState(() => _counter = 0);

  void _markDone() {
    context.read<AppState>().incrementActivitiesCompleted();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Activity 1 marked as completed!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity 1: Counter Lab')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          // Column + Row + Expanded keep this responsive across sizes.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'This counter is local state, owned only by this screen.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                '$_counter',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      label: 'Decrease',
                      icon: Icons.remove,
                      onPressed: _decrement,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label: 'Increase',
                      icon: Icons.add,
                      onPressed: _increment,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
              ),
              const SizedBox(height: 24),
              CustomButton(
                label: 'Mark Activity Complete',
                icon: Icons.check,
                onPressed: _markDone,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
