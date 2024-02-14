import 'package:app_client/blocs/notes_color_cubit.dart';
import 'package:app_client/blocs/notes_cubit.dart';
import 'package:app_client/ui/add_note_screen.dart';
import 'package:app_client/ui/main_screen.dart';
import 'package:app_client/ui/search_screen.dart';
import 'package:app_client/ui/show_note_screen.dart';
import 'package:app_client/ui/theme/app_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'blocs/notes_search_cubit.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  const initialSize = Size(400, 600);
  const minSize = Size(350, 400);
  //const maxSize = Size(1200, 850);
  //appWindow.maxSize = maxSize;
  appWindow.minSize = minSize;
  appWindow.size = initialSize; //default size
  appWindow.show();

  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await openDatabase(join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, isDone INTEGER DEFAULT 0, parentId INTEGER DEFAULT 0)');
  }, version: 1);

  runApp(const MyApp());

  doWhenWindowReady(() {
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NotesCubit>(
          create: (context) => NotesCubit(),
          dispose: (context, value) => value.close(),
        ),
        Provider<NotesColorCubit>(
          create: (context) => NotesColorCubit(),
          dispose: (context, value) => value.close(),
        ),
        Provider<NotesSearchCubit>(
          create: (context) => NotesSearchCubit(),
          dispose: (context, value) => value.close(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const NavigationScreen(),
          '/search': (context) => const SearchScreen(),
          '/add': (context) => NoteAddScreen(),
          '/show': (context) => ShowNoteScreen(),
        },
      ),
    );
  }
}
