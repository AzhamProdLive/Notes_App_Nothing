import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.onSearchPress,
  });

  final Function onSearchPress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'NOTES',
              style: TextStyle(
                  fontFamily: "Nothing",
                  fontWeight: FontWeight.normal,
                  fontSize: 44,
                  color: Colors.white),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => onSearchPress(),
                  borderRadius: BorderRadius.circular(18),
                  child: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                    size: 33,
                  ),
                ),
                const SizedBox(width: 15),
                /*
                InkWell(
                  onTap: () => onInfoPress(),
                  borderRadius: BorderRadius.circular(16),
                  child: Ink(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                    ),
                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ), */
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
