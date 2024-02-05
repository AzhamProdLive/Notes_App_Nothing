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

class MainScreen extends State<NavigationScreen> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();

    return Scaffold(
      appBar: MainAppBar(
        onSearchPress: () => Navigator.pushNamed(context, '/search'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.red,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: FloatingActionButton.extended(
          onPressed: () =>
          {
            Navigator.pushNamed(context, '/add'),
          },
          elevation: 24,
          backgroundColor: CustomColors.red,

          label: const Text(
            'Add Note', style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "Nunito-Bold"),),
          icon: const Icon(IconData(0xe900, fontFamily: "NothingIcon"), size: 26, color: Colors.white,),
        ),
      ),
    );
  }
}

