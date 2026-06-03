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

  @override
  void initState() {
    super.initState();

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
        controller: quillController,
      );
    } else {
      await provider.updateNote(
        id: widget.note!.id,
        title: titleController.text,
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

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Card(
                elevation: 1,
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

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _showToolbar
                  ? Container(
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
                    )
                  : const SizedBox(),
            ),

            Expanded(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
