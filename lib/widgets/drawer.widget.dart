import 'package:flutter/material.dart';
import 'package:my_first_app/pages/counter.page.dart';
import 'package:my_first_app/pages/github.page.dart';
import 'package:my_first_app/pages/home.page.dart';
import 'package:my_first_app/pages/pixabay.page.dart';
import 'package:my_first_app/widgets/drower.header.dart';

class MyDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:ListView(
        children: [
          MyDrowerHeader(),
          ListTile(
            title: Text("Home",style: TextStyle(
              fontSize: 20,
              color: Colors.orange
            ),),
             leading: Icon(Icons.home,color: Colors.deepOrange,),
            trailing: Icon(Icons.arrow_right,color: Colors.deepOrange ),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
          ),
          Divider(
            color: Colors.deepOrange,
            height: 1,
          ),
          ListTile(
            title: Text("Counter",style: TextStyle(
                fontSize: 20,
                color: Colors.orange
            ),),
            leading: Icon(Icons.countertops,color: Colors.deepOrange,),
            trailing: Icon(Icons.arrow_right,color: Colors.deepOrange ),
            onTap: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterPage()));
            }
          ),
          Divider(
            color: Colors.deepOrange,
            height: 1,
          ),
          ListTile(
            title: Text("get users",style: TextStyle(
                fontSize: 20,
                color: Colors.orange
            ),),
            leading: Icon(Icons.search,color: Colors.deepOrange,),
            trailing: Icon(Icons.arrow_right,color: Colors.deepOrange ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>gitHubPage()));
              }
          ),
          Divider(
            color: Colors.deepOrange,
            height: 1,
          ),
          ListTile(
              title: Text("get Pixabay",style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange
              ),),
              leading: Icon(Icons.collections_bookmark,color: Colors.deepOrange,),
              trailing: Icon(Icons.arrow_right,color: Colors.deepOrange ),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GalleryDataPage()));
              }
          ),
        ],
      ) ,
    );
  }
}
