import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note_sort.dart';
import '../provider/notes_provider.dart';
import '../widgets/note_card.dart';
import 'note_editor_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton<NoteSort>(
            icon: const Icon(Icons.sort),

            onSelected: (value) {
              provider.changeSort(value);
            },

            itemBuilder: (_) => const [
              PopupMenuItem(
                value: NoteSort.updatedAt,
                child: Text('Last Updated'),
              ),
              PopupMenuItem(
                value: NoteSort.createdAt,
                child: Text('Created Date'),
              ),
              PopupMenuItem(value: NoteSort.title, child: Text('Title A-Z')),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NoteEditorScreen()),
          );
        },

        child: const Icon(Icons.add),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: Theme.of(context).brightness == Brightness.dark
                ? const [Color(0xFF1A1A1A), Color(0xFF2A2A2A)]
                : const [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
          ),
        ),

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),

              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  prefixIcon: const Icon(Icons.search),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),

                onChanged: provider.searchNotes,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('All'),
                        selected: provider.selectedTag == null,
                        onSelected: (_) {
                          provider.filterByTag(null);
                        },
                      ),
                    ),

                    ...provider.allTags.map(
                      (tag) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text('#$tag'),

                          selected: provider.selectedTag == tag,

                          onSelected: (_) {
                            provider.filterByTag(tag);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.notes.isEmpty
                  ? const Center(child: Text('No Notes Found'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      itemCount: provider.notes.length,

                      itemBuilder: (context, index) {
                        final note = provider.notes[index];

                        return NoteCard(
                          note: note,
                          preview: provider.getPreview(note),

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NoteEditorScreen(note: note),
                              ),
                            );
                          },

                          onDelete: () async {
                            await provider.deleteNote(note.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


