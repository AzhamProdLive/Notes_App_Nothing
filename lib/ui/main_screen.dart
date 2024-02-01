import 'package:app_client/blocs/notes_state.dart';
import 'package:app_client/constants/custom_colors.dart';
import 'package:app_client/ui/appbar/main_app_bar.dart';
import 'package:app_client/ui/main_screen_with_content_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'main_screen_empty.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();

    return Scaffold(
      appBar: MainAppBar(
        onSearchPress: () => Navigator.pushNamed(context, '/search'),
      ),
      body: Padding(padding: const EdgeInsets.only(top: 40), child:
      StreamBuilder<NotesState>(
        initialData: cubit.state,
        stream: cubit.stream,
        builder: (context, snapshot) {
          if (snapshot.data!.currentNotes.isEmpty) {
            return const MainScreenEmpty();
          } else {
            return MainScreenWithContentGridView(
              notes: snapshot.requireData.currentNotes.reversed.toList(),
            );
          }
        },
      ),),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () =>
          {
            Navigator.pushNamed(context, '/add'),
          },
          elevation: 24,
          backgroundColor: CustomColors.trueBlack,

          label: const Text(
            'Add Note', style: TextStyle(fontSize: 20, color: Colors.white),),
          icon: const Icon(IconData(0xe900, fontFamily: "NothingIcon"), size: 26, color: Colors.white,),
        ),
      ),
    );
  }
}

