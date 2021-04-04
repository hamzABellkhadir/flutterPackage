import 'package:flutter/material.dart';
import 'package:my_first_app/widgets/drawer.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawerWidget(),
      appBar: AppBar(title: Text("Home page"),titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
      ),),
      body: Center(
        child: Text("home page from the roote"),
      ),
    );
  }
}
