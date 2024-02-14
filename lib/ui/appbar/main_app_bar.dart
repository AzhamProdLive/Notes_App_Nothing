import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:app_client/ui/main_screen.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.onSearchPress,
  });

  final Function onSearchPress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        MoveWindow(),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, '/add'),
                      borderRadius: BorderRadius.circular(18),
                      child: const Icon(
                        Icons.add_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => onSearchPress(),
                          borderRadius: BorderRadius.circular(18),
                          child: const Icon(
                            Icons.search_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        InkWell(
                          onTap: () => appWindow.close(),
                          borderRadius: BorderRadius.circular(18),
                          child: const Icon(
                            Icons.close_sharp,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NOTES',
                    style: TextStyle(
                        fontFamily: "Nothing",
                        fontWeight: FontWeight.normal,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82.0);
}
