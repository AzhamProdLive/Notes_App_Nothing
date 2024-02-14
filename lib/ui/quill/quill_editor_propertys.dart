import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter/cupertino.dart';

QuillEditor quillEditorPropertys(QuillController bodyController) {
  return QuillEditor.basic(
    configurations: QuillEditorConfigurations(
      enableInteractiveSelection: true,
      controller: bodyController,
      enableSelectionToolbar: true,
      textSelectionControls: CupertinoDesktopTextSelectionControls(),
      detectWordBoundary: true,
      disableClipboard: false,
      customStyles: const DefaultStyles(
          h1: DefaultTextBlockStyle(
              TextStyle(
                color: Colors.white,
                fontSize: 38,
              ),
              VerticalSpacing(
                0,
                0,
              ),
              VerticalSpacing(
                0,
                0,
              ),
              null),
          paragraph: DefaultTextBlockStyle(
              TextStyle(
                  color: Colors.white, fontSize: 21, fontFamily: "Nunito"),
              VerticalSpacing(
                0,
                0,
              ),
              VerticalSpacing(0, 0),
              null),
          h2: DefaultTextBlockStyle(
              TextStyle(
                  color: Colors.white, fontSize: 38, fontFamily: "Nothing"),
              VerticalSpacing(
                0,
                0,
              ),
              VerticalSpacing(0, 0),
              null),
          h3: DefaultTextBlockStyle(
              TextStyle(color: Colors.white60, fontSize: 21),
              VerticalSpacing(
                0,
                0,
              ),
              VerticalSpacing(0, 0),
              null)),
      readOnly: false,
      autoFocus: true,
      placeholder: "Nothing",
      sharedConfigurations: const QuillSharedConfigurations(
        locale: Locale('de'),
      ),
    ),
  );
}
