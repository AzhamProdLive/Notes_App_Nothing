import 'package:app_client/blocs/notes_color_state.dart';
import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:bloc/bloc.dart';

class NotesColorCubit extends Cubit<NotesColorState> {
  NotesColorCubit()
      : super(NotesColorState(noteColor: CustomColors.colorsData[0].value));

  Future<void> changeColor(int color) async {
    final updatedColor = state.copyWith(color);
    emit(updatedColor);
  }
}
