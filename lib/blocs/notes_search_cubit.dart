import 'package:app_client/blocs/notes_search_state.dart';
import 'package:app_client/repository/notes_repository.dart';
import 'package:bloc/bloc.dart';

import '../database/tables.dart';

class NotesSearchCubit extends Cubit<NotesSearchState> {
  final NotesRepository _repository = NotesRepository();

  NotesSearchCubit() : super(const NotesSearchState(currentNotes: <Note>[])) {}

  Future<void> getNoteByKeyword(String keyword) async {
    final newNotes =
        state.copyWith(await _repository.getNotesByKeyword(keyword));
    emit(newNotes);
  }
}
