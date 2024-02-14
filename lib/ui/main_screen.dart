import 'package:app_client/blocs/notes_state.dart';
import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:app_client/ui/appbar/main_app_bar.dart';
import 'package:app_client/ui/main_screen_with_content_grid.dart';
import 'package:app_client/ui/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'main_screen_empty.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => MainScreen();
}

class MainScreen extends State<NavigationScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

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
          height: 60,
          surfaceTintColor: Colors.black,
          overlayColor: const MaterialStatePropertyAll<Color>(Colors.black),
          shadowColor: Colors.black,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              currentPageIndex = index;
            });
          },
          backgroundColor: CustomColors.backgroundColor,
          indicatorColor: CustomColors.lightGrey,
          indicatorShape: RoundedRectangleBorder(
            side: const BorderSide(width: 100),
            borderRadius: BorderRadius.circular(50),
          ),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Badge(
                  child: Icon(
                Icons.file_copy_rounded,
                color: Colors.white,
              )),
              label: 'Notes',
            ),
            NavigationDestination(
              icon: Badge(
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
              ),
              label: "Tasks",
            ),
          ],
        ),
        body: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: StreamBuilder<NotesState>(
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
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: TaskListScreen(),
          ),
        ][currentPageIndex],
        floatingActionButton: Builder(
          builder: (context) {
            if (currentPageIndex == 0) {
              return Container();
            } else {
              return addTaskButton(context);
            }
          },
        ));
  }
}
