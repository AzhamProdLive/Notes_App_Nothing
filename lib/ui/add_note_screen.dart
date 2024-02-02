import 'dart:convert';

import 'package:app_client/blocs/notes_color_cubit.dart';
import 'package:app_client/blocs/notes_color_state.dart';
import 'package:app_client/blocs/notes_cubit.dart';
import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:app_client/ui/appbar/add_note_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';


class NoteAddScreen extends StatelessWidget {
  NoteAddScreen({super.key});

  final _titleController = TextEditingController();
  final _bodyController = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    var notesCubit = context.read<NotesCubit>();
    var colorCubit = context.read<NotesColorCubit>();

    return StreamBuilder<NotesColorState>(
        initialData: colorCubit.state,
        stream: colorCubit.stream,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AddNoteAppBar(
              color: colorCubit.state.noteColor,
              onSavePress: () => saveNote(notesCubit, colorCubit, context),
              onDeletPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                        "Are you sure you wish to delete this note?",
                        style: TextStyle(fontSize: 19),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          onPressed: () =>  {
                            Navigator.pop(context),
                            saveNote(notesCubit, colorCubit, context),
                          },
                          child: const Text(
                            "SAVE",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => {
                             Navigator.pop(context),
                            Navigator.pop(context)
                          },
                          child: const Text(
                            "DELETE",
                            style: TextStyle(color: CustomColors.deepRed),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white24),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              onColorChangePress: () => changeColor(context, colorCubit),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        fillColor: CustomColors.backgroundColor,
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 38, fontFamily: "Nothing"),
                    ),
                    const SizedBox(height: 14),
                    QuillToolbar.simple(
                      configurations: QuillSimpleToolbarConfigurations(
                        controller: _bodyController,
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                    ),
                    QuillEditor.basic(
                      configurations: QuillEditorConfigurations(
                        controller: _bodyController,
                        readOnly: false,
                        autoFocus: true,
                        placeholder: "Nothing",
                        sharedConfigurations: const QuillSharedConfigurations(
                          locale: Locale('de'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> changeColor(BuildContext context, NotesColorCubit colorCubit) {
    return showDialog(
      context: context,
      builder: (context) => StreamBuilder<NotesColorState>(
          initialData: colorCubit.state,
          stream: colorCubit.stream,
          builder: (context, snapshot) {
            return AlertDialog(
              content: SizedBox(
                width: 210,
                height: 110,
                child: GridView.builder(
                  itemCount: CustomColors.colorsData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () => {
                          colorCubit.changeColor(
                              CustomColors.colorsData[index].value),
                          Navigator.pop(context)
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            color: CustomColors.colorsData[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }

  void saveNote(
      NotesCubit cubit, NotesColorCubit colorCubit, BuildContext context) {
    while (true) {
      if (_titleController.text.isNotEmpty) {
          cubit.addNote(_titleController.text, jsonEncode(_bodyController.document.toDelta().toJson()),
              colorCubit.state.noteColor);
          Navigator.pop(context);
          break;
      }else{
        _titleController.text = "Title";
      }
    }
  }
}
