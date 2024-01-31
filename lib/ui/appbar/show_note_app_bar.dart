import 'package:app_client/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class ShowNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ShowNoteAppBar(
      {super.key,
      required this.onColorChangePress,
        required this.onDeletPressed,
      required this.color,
      required this.onBackPressed});

  final Function onBackPressed;
  final Function onDeletPressed;
  final Function onColorChangePress;
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
              onTap: () => {onBackPressed()},
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
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => onColorChangePress(),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Color(color),
                    ),
                    child: Container(
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                InkWell(
                  onTap: () => onDeletPressed(),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: CustomColors.lightGrey,
                    ),
                    child: const Icon(
                      IconData(0xe910, fontFamily: "NothingIcon"),
                      color: Colors.white,
                    ),
                  ),),
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
