class NotesColorState {
  final int noteColor;

  const NotesColorState({required this.noteColor});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotesColorState &&
            runtimeType == other.runtimeType &&
            noteColor == other.noteColor);
  }

  @override
  int get hashCode => noteColor.hashCode;

  NotesColorState copyWith(int newNoteColor) {
    return NotesColorState(noteColor: newNoteColor);
  }
}
