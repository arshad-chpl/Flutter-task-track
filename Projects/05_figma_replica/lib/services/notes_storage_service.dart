import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/note_model.dart';

class NotesStorageService {
  static const String notesKey = 'notes';

  Future<void> saveNotes(List<NoteModel> notes) async {
    final prefs = await SharedPreferences.getInstance();

    final notesJson = notes
        .map((note) => jsonEncode(note.toJson()))
        .toList();

    await prefs.setStringList(notesKey, notesJson);
  }

  Future<List<NoteModel>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final notesJson = prefs.getStringList(notesKey);

    if (notesJson == null || notesJson.isEmpty) {
      return [];
    }

    return notesJson.map((note) {
      return NoteModel.fromJson(
        jsonDecode(note),
      );
    }).toList();
  }

  Future<void> clearNotes() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(notesKey);
  }
}