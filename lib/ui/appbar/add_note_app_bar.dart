import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';


class AddNoteAppBar extends StatelessWidget implements PreferredSizeWidget{
  const AddNoteAppBar(
      {super.key,
      required this.onSavePress,
      required this.onColorChangePress,
        required this.onDeletPressed,
      required this.color});

  final Function onSavePress;
  final Function onColorChangePress;
  final Function onDeletPressed;
  final int color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => onDeletPressed(),
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                  color: CustomColors.lightGrey,
                ),
                child: const Icon(
                  IconData(0xe901, fontFamily: "NothingIcon"),
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 22),
                InkWell(
                  onTap: () => onColorChangePress(),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration:  BoxDecoration(
                      //border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Color(color),
                    ),
                    child: /*const Icon(
                      Icons.palette_outlined,
                      color: Colors.white,
                    ),*/
                    Container()
                  ),
                ),
                const SizedBox(width: 22),
                InkWell(
                  onTap: () => onSavePress(),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: CustomColors.lightGrey,
                    ),
                    child: const Icon(
                      IconData(0xe902, fontFamily: "NothingIcon"),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82.0);
}
