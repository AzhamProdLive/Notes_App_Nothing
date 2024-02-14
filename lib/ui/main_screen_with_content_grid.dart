import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'theme/custom_colors.dart';
import '../database/tables.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class MainScreenWithContentGridView extends StatelessWidget {
  const MainScreenWithContentGridView({
    super.key,
    required this.notes,
  });
  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    @override
    ScrollController _scrollController = ScrollController();
    var cubit = context.read<NotesCubit>();

    return CupertinoScrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: notes.length,
              itemBuilder: (context, index) => Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: CustomColors.lightGrey,
                        content: const Text(
                          "Are you sure you wish to delete this note?",
                          style: TextStyle(fontSize: 19),
                        ),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: () => {
                              cubit.deleteNote(notes[index]),
                              Navigator.of(context).pop(true)
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
                key: UniqueKey(),
                direction: DismissDirection.horizontal,
                background: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: CustomColors.deepRed,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.delete_rounded,
                        size: 36, color: Colors.white),
                  ),
                ),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/show',
                      arguments: {'note': notes[index]}),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(notes[index].color),
                        border: Border.all(
                          width: 2,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      /*decoration: BoxDecoration(
                              /*gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colors.black.withAlpha(0),
                                  Colors.black12,
                                  Colors.black87,
                                ],
                              ),*/
                            ),*/
                      child: Center(
                        child: ListTile(
                            title: Text(
                              notes[index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: titleColor(Color(notes[index].color)),
                                  fontFamily: "Nothing"),
                            ),
                            subtitle: Text(
                              Document.fromJson(
                                      json.decode(notes[index].content))
                                  .toPlainText(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textColor(Color(notes[index].color))),
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}

int gridCrossAxisCount(int noteslength, BuildContext context) {
  int avSpace = MediaQuery.of(context).size.width ~/ 150;
  if (avSpace < noteslength) {
    return avSpace;
  } else {
    return noteslength;
  }
}

Color textColor(Color indexColor) {
  if (indexColor == CustomColors.whiteMain) {
    return Colors.black54;
  } else {
    return Colors.white54;
  }
}

Color titleColor(Color indexColor) {
  if (indexColor == CustomColors.whiteMain) {
    return Colors.black;
  } else {
    return Colors.white;
  }
}

Widget addNoteButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 16, bottom: 16),
    child: FloatingActionButton.extended(
      onPressed: () => {
        Navigator.pushNamed(context, '/add'),
      },
      elevation: 24,
      backgroundColor: CustomColors.red,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: CustomColors.lightGrey, width: 2),
        borderRadius: BorderRadius.circular(
          40,
        ),
      ),
      label: const Text(
        'Add Note',
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontFamily: "Nunito-Bold"),
      ),
      icon: const Icon(
        Icons.add,
        size: 26,
        color: Colors.white,
      ),
    ),
  );
}
