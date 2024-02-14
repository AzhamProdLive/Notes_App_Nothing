import 'package:app_client/ui/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

Widget QuillToolbarWidget(QuillController bodyController) {
  return Container(
    constraints: const BoxConstraints(maxHeight: 100),
    child: QuillToolbar.simple(
      configurations: QuillSimpleToolbarConfigurations(
        controller: bodyController,
        color: CustomColors.backgroundColor,
        multiRowsDisplay: true,
        headerStyleType: HeaderStyleType.buttons,
        showBackgroundColorButton: false,
        showColorButton: false,
        showDividers: false,
        showLink: false,
        showUndo: false,
        showRedo: false,
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
