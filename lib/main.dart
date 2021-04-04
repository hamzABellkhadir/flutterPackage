
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_first_app/pages/github.page.dart';
import 'package:my_first_app/pages/home.page.dart';
import 'package:my_first_app/widgets/drawer.widget.dart';
import 'package:my_first_app/widgets/drower.header.dart';
void main(){
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  int a=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 15,
          )
        )
      ),
      routes: {
        "/": (context)=> HomePage(),
      },

    );
  }
}
/*
floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: (){
                this.a--;

                print('remove $a');
              },
            ),
            SizedBox(width: 10,),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                this.a++;
                print('add $a');
              },
            ),
*
**/