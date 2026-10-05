import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

/// Activity2Screen is another StatefulWidget: it owns a local list of
/// notes and a TextEditingController. None of this needs to be visible
/// to any other screen, which is exactly when local state (as opposed
/// to global Provider state) is the right tool.
class Activity2Screen extends StatefulWidget {
  const Activity2Screen({super.key});

  @override
  State<Activity2Screen> createState() => _Activity2ScreenState();
}

class _Activity2ScreenState extends State<Activity2Screen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _notes.add(text);
      _controller.clear();
    });
  }

  void _removeNote(int index) => setState(() => _notes.removeAt(index));

  void _markDone() {
    context.read<AppState>().incrementActivitiesCompleted();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Activity 2 marked as completed!')),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity 2: Notes Lab'),
        actions: [
          IconButton(
            tooltip: 'Mark complete',
            icon: const Icon(Icons.check_circle_outline),
            onPressed: _markDone,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Column of: input Row, then Expanded list -- responsive layout
        // that never overflows regardless of how many notes are added.
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Write a quick note...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addNote(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addNote,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _notes.isEmpty
                  ? const Center(child: Text('No notes yet. Add one above.'))
                  : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text('${index + 1}')),
                          title: Text(_notes[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _removeNote(index),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
