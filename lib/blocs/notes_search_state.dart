import 'package:app_client/database/tables.dart';

class NotesSearchState {
  final List<Note> currentNotes;

  const NotesSearchState({required this.currentNotes});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotesSearchState &&
            runtimeType == other.runtimeType &&
            currentNotes == other.currentNotes);
  }

  @override
  int get hashCode => currentNotes.hashCode;

  NotesSearchState copyWith(List<Note> newNotes) {
    return NotesSearchState(currentNotes: newNotes);
  }
}
