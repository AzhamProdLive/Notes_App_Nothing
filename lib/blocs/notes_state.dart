import 'package:app_client/database/tables.dart';

class NotesState {
  final List<Note> currentNotes;

  const NotesState({required this.currentNotes});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotesState &&
            runtimeType == other.runtimeType &&
            currentNotes == other.currentNotes);
  }

  @override
  int get hashCode => currentNotes.hashCode;

  NotesState copyWith(List<Note> newNotes) {
    return NotesState(currentNotes: newNotes);
  }
}
