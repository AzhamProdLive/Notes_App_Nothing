import 'package:flutter/material.dart';

class MainScreenEmpty extends StatelessWidget {
  const MainScreenEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(child:
          //Image.asset('assets/images/no_data.png'),
          Text(
            '  Create your first note!',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
      ),
    );
  }
}
