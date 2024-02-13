import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

Widget QuillToolbarWidget(QuillController bodyController) {
  return SizedBox(
    height: 50,
    child: QuillToolbar.simple(
      configurations: QuillSimpleToolbarConfigurations(
        controller: bodyController,
        color: Colors.black54,
        multiRowsDisplay: false,
        headerStyleType: HeaderStyleType.buttons,
        showBackgroundColorButton: false,
        showColorButton: false,
        showDividers: false,
        showFontFamily: false,
        showFontSize: false,
        showCodeBlock: false,
        showAlignmentButtons: true,
        showClearFormat: false,
        showIndent: false,
        showInlineCode: false,
        showQuote: false,
        showSearchButton: false,
        showSmallButton: false,
        showSuperscript: false,
        showDirection: false,
        showJustifyAlignment: true,
        showSubscript: false,
        toolbarSize: 35,
        sectionDividerColor: Colors.white,
        buttonOptions: const QuillSimpleToolbarButtonOptions(
          color:
              QuillToolbarColorButtonOptions(dialogBarrierColor: Colors.black),
          base: QuillToolbarBaseButtonOptions(
            iconTheme: QuillIconTheme(
                iconButtonUnselectedData: IconButtonData(
              color: Colors.white,
            )),
          ),
        ),
      ),
    ),
  );
}
