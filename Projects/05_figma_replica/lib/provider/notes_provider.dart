import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../models/note_model.dart';
import '../models/note_sort.dart';
import '../services/notes_storage_service.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider() {
    loadNotes();
  }

  final NotesStorageService _storageService = NotesStorageService();

  List<NoteModel> _notes = [];
  List<NoteModel> _filteredNotes = [];

  bool _isLoading = false;
  String? _selectedTag;

  String? get selectedTag => _selectedTag;

  String _searchQuery = '';

  NoteSort _currentSort = NoteSort.updatedAt;

  List<NoteModel> get notes => _filteredNotes;

  bool get isLoading => _isLoading;

  NoteSort get currentSort => _currentSort;

  List<String> get allTags {
    final tags = <String>{};

    for (final note in _notes) {
      tags.addAll(note.tags);
    }
    return tags.toList()..sort();
  }

  Future<void> loadNotes() async {
    try {
      _isLoading = true;
      notifyListeners();
      _notes = await _storageService.getNotes();
      _applyFilters();
    } catch (e) {
      debugPrint('Load Notes Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote({
    required String title,
    required List<String> tags,
    required QuillController controller,
  }) async {
    final note = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      tags: tags,
      contentJson: jsonEncode(controller.document.toDelta().toJson()),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _notes.insert(0, note);

    await _storageService.saveNotes(_notes);
    _applyFilters();
    notifyListeners();
  }

  Future<void> updateNote({
    required String id,
    required String title,
    required List<String> tags,
    required QuillController controller,
  }) async {
    final index = _notes.indexWhere((note) => note.id == id);

    if (index == -1) return;

    final existingNote = _notes[index];

    _notes[index] = NoteModel(
      id: existingNote.id,

      title: title.trim(),
      tags: tags,
      contentJson: jsonEncode(controller.document.toDelta().toJson()),
      createdAt: existingNote.createdAt,
      updatedAt: DateTime.now(),
    );

    await _storageService.saveNotes(_notes);
    _applyFilters();
    notifyListeners();
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    await _storageService.saveNotes(_notes);
    _refreshNotes();
  }

  void searchNotes(String query) {
    _searchQuery = query;
    _refreshNotes();
  }

  void changeSort(NoteSort sort) {
    _currentSort = sort;
    _refreshNotes();
  }

  void _refreshNotes() {
    _applyFilters();
    notifyListeners();
  }

  void filterByTag(String? tag) {
    _selectedTag = tag;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    List<NoteModel> result = List.from(_notes);

    if (_searchQuery.trim().isNotEmpty) {
      final searchText = _searchQuery.toLowerCase();

      result = result.where((note) {
        final document = Document.fromJson(jsonDecode(note.contentJson));

        final content = document.toPlainText().toLowerCase();

        return note.title.toLowerCase().contains(searchText) ||
            content.contains(searchText);
      }).toList();
    }

    if (_selectedTag != null) {
      result = result.where((note) {
        return note.tags.contains(_selectedTag);
      }).toList();
    }

    switch (_currentSort) {
      case NoteSort.updatedAt:
        result.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        break;

      case NoteSort.createdAt:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;

      case NoteSort.title:
        result.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );
        break;
    }
    _filteredNotes = result;
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