import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../models/note_model.dart';
import '../services/notes_storage_service.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider() {
    loadNotes();
  }
  final NotesStorageService _storageService = NotesStorageService();

  List<NoteModel> _notes = [];
  List<NoteModel> _filteredNotes = [];

  bool _isLoading = false;

  List<NoteModel> get notes => _filteredNotes;
  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    try {
      _isLoading = true;
      notifyListeners();

      _notes = await _storageService.getNotes();
      _filteredNotes = List.from(_notes);
    } catch (e) {
      debugPrint('Load Notes Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote({
    required String title,
    required QuillController controller,
  }) async {
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      contentJson: jsonEncode(controller.document.toDelta().toJson()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _notes.insert(0, note);

    await _storageService.saveNotes(_notes);

    _filteredNotes = List.from(_notes);

    notifyListeners();
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required QuillController controller,
  }) async {
    final index = _notes.indexWhere((note) => note.id == id);

    if (index == -1) return;

    final existingNote = _notes[index];

    _notes[index] = NoteModel(
      id: existingNote.id,
      title: title.trim(),
      contentJson: jsonEncode(controller.document.toDelta().toJson()),
      createdAt: existingNote.createdAt,
      updatedAt: DateTime.now(),
    );

    await _storageService.saveNotes(_notes);

    _filteredNotes = List.from(_notes);

    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);

    await _storageService.saveNotes(_notes);

    _filteredNotes = List.from(_notes);

    notifyListeners();
  }

  void searchNotes(String query) {
    if (query.trim().isEmpty) {
      _filteredNotes = List.from(_notes);
      notifyListeners();
      return;
    }

    final searchText = query.toLowerCase();

    _filteredNotes = _notes.where((note) {
      final document = Document.fromJson(jsonDecode(note.contentJson));

      final content = document.toPlainText().toLowerCase();

      return note.title.toLowerCase().contains(searchText) ||
          content.contains(searchText);
    }).toList();

    notifyListeners();
  }

  String getPreview(NoteModel note) {
    try {
      final document = Document.fromJson(jsonDecode(note.contentJson));
      return document.toPlainText().trim();
    } catch (_) {
      return '';
    }
  }

  QuillController createController(NoteModel note) {
    final document = Document.fromJson(jsonDecode(note.contentJson));
    return QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }
}
