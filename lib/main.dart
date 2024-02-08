import 'package:app_client/blocs/notes_color_cubit.dart';
import 'package:app_client/blocs/notes_cubit.dart';
import 'package:app_client/ui/add_note_screen.dart';
import 'package:app_client/ui/main_screen.dart';
import 'package:app_client/ui/search_screen.dart';
import 'package:app_client/ui/show_note_screen.dart';
import 'package:app_client/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_client/background_service/background_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'blocs/notes_search_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await openDatabase(join(await getDatabasesPath(), 'tasks_database.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, isDone INTEGER DEFAULT 0, parentId INTEGER DEFAULT 0)');
      }, version: 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          '/bc': (context) => const LoadingScreen(),
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold( body: Container(color: Colors.white),
    )
    );
  }}