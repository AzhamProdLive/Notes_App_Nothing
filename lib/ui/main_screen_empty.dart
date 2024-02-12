import 'package:flutter/material.dart';

class MainScreenEmpty extends StatelessWidget {
  const MainScreenEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(child:
          Stack(
            children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 0),
              child: Image.asset("assets/images/No Notes - 1.png"),),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black87
                  ],
                ),
              ),
                child: const Text(
              'Create your first note!',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),)
            ],)
      ),
    );
  }
}
