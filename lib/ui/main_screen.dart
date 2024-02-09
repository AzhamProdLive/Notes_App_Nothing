import 'package:app_client/blocs/notes_state.dart';
import 'package:app_client/database/tables.dart';
import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:app_client/ui/appbar/main_app_bar.dart';
import 'package:app_client/ui/main_screen_with_content_grid.dart';
import 'package:app_client/ui/tasks_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'main_screen_empty.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => MainScreen();
}

class MainScreen extends State<NavigationScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var notesCubit = context.read<NotesCubit>();
    var cubit = context.read<NotesCubit>();

    return Scaffold(
      appBar: MainAppBar(
        onSearchPress: () => Navigator.pushNamed(context, '/search'),
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.black,

        overlayColor: const MaterialStatePropertyAll<Color>(Colors.black),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        indicatorColor: CustomColors.lightGrey,
        indicatorShape: RoundedRectangleBorder(side: const BorderSide(width: 100), borderRadius: BorderRadius.circular(50), ),
        selectedIndex: currentPageIndex,
        destinations:  const <Widget>[
          NavigationDestination(
            icon: Badge(child: Icon(Icons.file_copy_rounded, color: Colors.white,)),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Badge(
              child: Icon(Icons.calendar_today_outlined, color: Colors.white,),
            ),
            label: "To Do's",
          ),
        ],
      ),
      body: <Widget>[
         Padding(padding: const EdgeInsets.only(top: 30),  child:
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
        Padding(padding: const EdgeInsets.only(top: 30),  child:TaskListScreen(),),
      ][currentPageIndex],
      floatingActionButton: Builder(builder: (context) {
        if (currentPageIndex == 0) {
          return addNoteButton(context);
        }else{
          return addTaskButton(context);
        }
      },)
    );
  }
}

