import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/notes_cubit.dart';
import 'theme/custom_colors.dart';
import '../database/tables.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class MainScreenWithContentGridView extends StatelessWidget {
  const MainScreenWithContentGridView({
    Key? key,
    required this.notes,
  }) : super(key: key);

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NotesCubit>();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
          GridView.count(crossAxisCount: 2,

            children: List.generate(notes.length, (index) {
              int row = index ~/ 2;
              double dx = -30.0 * (row + 1);
             return Container( transform: Matrix4.translationValues(0, dx, 0),
                 child:  Dismissible(
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
                background: Container(
                  color: CustomColors.deepRed,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                    Icon(Icons.delete_rounded, size: 36, color: Colors.white),
                  ),
                ),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/show',
                      arguments: {'note': notes[index]}),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(notes[index].color),
                      border: Border.all(width: 2, ),
                        borderRadius: const BorderRadius.all(Radius.circular(20))
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withAlpha(0),
                            Colors.black12,
                            Colors.black87,
                          ],
                        ),
                      ),
                      child: Center( child: ListTile( title:  Text(
                      notes[index].title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style:  TextStyle(fontSize: 25, color: titleColor(Color(notes[index].color)), fontFamily: "Nothing"),),
                      subtitle:
                      Text(
                        Document.fromJson(json.decode(notes[index].content)).toPlainText(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 16, color: textColor(Color(notes[index].color))),)
                    ),
                    ),
                  ),
                ), )
              ));
            })
          )
    );
  }
}

Color textColor(Color indexColor ) {
  if (indexColor == const Color.fromRGBO(239, 239, 239, 1.0)){
    return Colors.black54;
  }else{
    return Colors.white54;
  }
}

Color titleColor(Color indexColor ) {
  if (indexColor == const Color.fromRGBO(239, 239, 239, 1.0)){
    return Colors.black;
  }else{
    return Colors.white;
  }
}

Widget addNoteButton(BuildContext context) {
  return  Padding(
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
  );
}