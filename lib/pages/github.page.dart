import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/pages/repos/user.repo.page.dart';

class gitHubPage extends StatefulWidget {
  @override
  _gitHubPageState createState() => _gitHubPageState();
}

class _gitHubPageState extends State<gitHubPage> {
  String query = "";
  bool notVisible = false;
  int currentPage=0;
  int totalPages=0;
  int pageSize=20;
  dynamic data;
  TextEditingController queryTextEditingController =
      new TextEditingController();
  List<dynamic> items=[];
  ScrollController scrollController=new ScrollController();

  //function-------

  void _search(String query){
    String urll="https://api.github.com/search/users?q=${query}&per_page=$pageSize&page=$currentPage";
    print(urll);
    http.get(Uri.parse(urll))
        .then((response){
      setState(() {
        data=json.decode(response.body);
       this.items.addAll(data['items']);
        if(data['total_count'] % pageSize ==0){
          totalPages=data['total_count']~/pageSize;
        } else totalPages=(data['total_count']/pageSize).floor() +1;
      });
    })
        .catchError((err){
      print(err);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        setState(() {
          if(currentPage<totalPages-1){
            ++currentPage;
            _search(query);
          }
        });
      }
    });
  }

  // render page --------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("get the gitHub users => $query"),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        this.query = value;
                      });
                    },
                    controller: queryTextEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(width: 1, color: Colors.deepOrange)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            notVisible = !notVisible;
                          });
                        },
                        icon: Icon(notVisible == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    obscureText: this.notVisible,
                  )),
                  IconButton(
                      icon: Icon(Icons.search, color: Colors.deepOrange),
                      onPressed: () {
                        setState(() {
                          items=[];
                          currentPage=0;
                          this.query=queryTextEditingController.text;
                          _search(query);
                        });
                      })
                ],
              ),

              Expanded(
                child: ListView.separated(

                    separatorBuilder: (context, index) =>
                        Divider(height: 2,color: Colors.deepOrange,),
                    controller: scrollController,
                    itemCount: items.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context)=>GitRepositoriesPage(
                                login:items[index]['login'],
                                avatarUrl:items[index]['avatar_url'] ,
                              )));
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(items[index]['avatar_url']),
                                  radius: 40,
                                ),
                                SizedBox(width: 20,),
                                Text("${items[index]['login']}"),
                              ],
                            ),
                            CircleAvatar(
                              child:Text("${items[index]['score']}") ,
                            )
                          ],
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ));
  }
}
