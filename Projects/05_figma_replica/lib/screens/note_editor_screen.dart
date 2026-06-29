import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

import '../models/note_model.dart';
import '../provider/notes_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteModel? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController titleController;
  late QuillController quillController;

  final FocusNode _editorFocusNode = FocusNode();

  bool _showToolbar = false;

  final TextEditingController tagController = TextEditingController();

  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    tags = List.from(widget.note?.tags ?? []);

    titleController = TextEditingController(text: widget.note?.title ?? '');

    if (widget.note != null) {
      quillController = context.read<NotesProvider>().createController(
        widget.note!,
      );
    } else {
      quillController = QuillController.basic();
    }

    _editorFocusNode.addListener(() {
      setState(() {
        _showToolbar = _editorFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    quillController.dispose();
    _editorFocusNode.dispose();
    tagController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final provider = context.read<NotesProvider>();

    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a title')));
      return;
    }

    if (widget.note == null) {
      await provider.addNote(
        title: titleController.text,
        tags: tags,
        controller: quillController,
      );
    } else {
      await provider.updateNote(
        id: widget.note!.id,
        title: titleController.text,
        tags: tags,
        controller: quillController,
      );
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: _saveNote,
              icon: const Icon(Icons.check_circle),
            ),
          ),
        ],
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

        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),

          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Card(
                  child: TextField(
                    controller: titleController,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Note title',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: tagController,
                            decoration: const InputDecoration(
                              hintText: 'Add tag',
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            final tag = tagController.text.trim().toLowerCase();

                            if (tag.isEmpty) return;
                            
                            if (!tags.contains(tag)) {
                              setState(() {
                                tags.add(tag);
                              });
                            }

                            tagController.clear();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),


              if (tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags.map((tag) {
                      return Chip(
                        label: Text(tag),
                        onDeleted: () {
                          setState(() {
                            tags.remove(tag);
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),

              const SizedBox(height: 10),

              if (_showToolbar)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    border: Border(
                      bottom: BorderSide(color: theme.dividerColor),
                    ),
                  ),
                  child: QuillSimpleToolbar(
                    controller: quillController,
                    config: const QuillSimpleToolbarConfig(
                      showBoldButton: true,
                      showItalicButton: true,
                      showUnderLineButton: true,
                      showUndo: true,
                      showRedo: true,
                      showAlignmentButtons: true,
                      showClipboardCut: true,
                      showFontFamily: false,
                      showBackgroundColorButton: false,
                      showHeaderStyle: false,
                      showCodeBlock: false,
                      showInlineCode: false,
                      showSearchButton: false,
                      showSubscript: false,
                      showSuperscript: false,
                      showStrikeThrough: false,
                      showDividers: false,
                    ),
                  ),
                ),

              Container(
                height: 500,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: QuillEditor(
                  controller: quillController,
                  focusNode: _editorFocusNode,
                  scrollController: ScrollController(),
                  config: const QuillEditorConfig(
                    placeholder: 'Start writing...',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
