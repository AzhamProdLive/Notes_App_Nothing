import 'package:app_client/blocs/notes_state.dart';
import 'package:app_client/repository/notes_repository.dart';
import 'package:bloc/bloc.dart';

import '../database/tables.dart';

class NotesCubit extends Cubit<NotesState> {
  final NotesRepository _repository = NotesRepository();

  NotesCubit() : super(const NotesState(currentNotes: <Note>[])) {
    _initialize();
  }

  Future<void> _initialize() async {
    final newNotes = state.copyWith(await _repository.getAllNotes());
    emit(newNotes);
  }

  Future<void> deleteNote(Note note) async {
    await _repository.deleteNote(note);
    final newNotes = state.copyWith(await _repository.getAllNotes());
    emit(newNotes);
  }

  Future<void> updateNote(Note note) async {
    await _repository.updateNote(note);
    final newNotes = state.copyWith(await _repository.getAllNotes());
    emit(newNotes);
  }

  Future<void> addNote(String title, String content, int color) async {
    await _repository.addNote(title, content, color);
    final newNotes = state.copyWith(await _repository.getAllNotes());
    emit(newNotes);
  }

  Future<List<Note>> getNoteByKeyword(String keyword) async {
    return await _repository.getNotesByKeyword(keyword);
  }
}
