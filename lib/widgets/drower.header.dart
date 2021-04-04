import 'package:flutter/material.dart';
class MyDrowerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DrawerHeader(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.deepOrange,
                  Colors.white
                ]
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("images/logo2.jpg"),
              radius: 50,
            )
          ],

        )
    );
  }
}
