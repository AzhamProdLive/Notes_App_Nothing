import 'package:drift/drift.dart';

import '../database/tables.dart';

class NotesRepository {
  final MyDatabase _database = MyDatabase();

  Future<void> addNote(String title, String content, int color) async {
    await _database.into(_database.notes).insert(
        NotesCompanion.insert(title: title, content: content, color: color));
  }

  Future<void> deleteNote(Note note) async {
    await _database.delete(_database.notes).delete(note);
  }

  Future<void> updateNote(Note note) async {
    await _database.update(_database.notes).replace(note);
  }

  Future<List<Note>> getAllNotes() async {
    return await _database.select(_database.notes).get();
  }

  Future<List<Note>> getNotesByKeyword(String keyword) async {
    return await (_database.select(_database.notes)
          ..where(
            (a) => a.title.contains(keyword) | a.content.contains(keyword),
          ))
        .get();
  }
}
