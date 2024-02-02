import 'package:app_client/blocs/notes_color_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_color_cubit.dart';
import '../blocs/notes_cubit.dart';
import 'theme/custom_colors.dart';
import '../database/tables.dart';
import 'appbar/show_note_app_bar.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class ShowNoteScreen extends StatelessWidget {
  ShowNoteScreen({super.key});

  final _titleController = TextEditingController();
  final _bodyController = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();
    var colorCubit = context.read<NotesColorCubit>();

    Note note = (ModalRoute.of(context)?.settings.arguments as Map)['note'];

    colorCubit.changeColor(note.color);
    _titleController.text = note.title;
    _bodyController.document = Document.fromJson(json.decode(note.content));

    return StreamBuilder<NotesColorState>(
        stream: colorCubit.stream,
        initialData: colorCubit.state,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: ShowNoteAppBar(
              onBackPressed: () async {
                await saveChanges(context, cubit, colorCubit, note);
              },
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
                          onPressed: () => {
                            cubit.deleteNote(note),
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              color: colorCubit.state.noteColor,
              onColorChangePress: () => changeColor(context, colorCubit),
            ),
            body: WillPopScope(
              onWillPop: () async {
                return await saveChanges(context, cubit, colorCubit, note);
              },
              child: SingleChildScrollView(
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
                          fillColor: CustomColors.backgroundColor,
                        ),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 38, fontFamily: "Nothing"),
                      ),
                      const SizedBox(height: 14),
                      QuillToolbar.simple(
                        configurations: QuillSimpleToolbarConfigurations(
                          controller: _bodyController,
                          headerStyleType: HeaderStyleType.buttons,
                          showBackgroundColorButton: false,
                          showColorButton: false,
                          showDividers: false,
                          showFontFamily: false,
                          showFontSize: false,
                          showCodeBlock: false,
                          sectionDividerColor: Colors.white,
                          buttonOptions: QuillSimpleToolbarButtonOptions(base: QuillToolbarBaseButtonOptions( iconTheme: QuillIconTheme(iconButtonUnselectedData: IconButtonData(color: Colors.white, )), ),),
                          sharedConfigurations: const QuillSharedConfigurations(
                            dialogBarrierColor: Colors.white,
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
                        colorCubit
                            .changeColor(CustomColors.colorsData[index].value),
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
        },
      ),
    );
  }

  Future<bool> saveChanges(BuildContext context, NotesCubit cubit,
      NotesColorCubit colorCubit, Note note) async {
    cubit.updateNote(Note(
        id: note.id,
        title: _titleController.text,
        content: jsonEncode(_bodyController.document.toDelta().toJson(),),
        color: colorCubit.state.noteColor));
    Navigator.pop(context);
    return false;
  }
}
