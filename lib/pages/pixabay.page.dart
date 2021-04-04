import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GalleryDataPage extends StatefulWidget {
  @override
  _GalleryDataPageState createState() => _GalleryDataPageState();
}

class _GalleryDataPageState extends State<GalleryDataPage> {
  List<dynamic> data;
  String query = "";
  int currentPage = 1;
  bool notVisible = false;
  int pageSize = 10;
  int totalPages = 0;
  ScrollController _scrollController = new ScrollController();
  TextEditingController queryTextEditingController =
      new TextEditingController();
  var dataGallery;
  List<dynamic> hits = [];

  // function declaration -------------
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    this._scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          ++currentPage;
          this.loadData(query);
        }
      }
    });
  }

  loadData(q) {
    String url =
        'https://pixabay.com/api/?key=21004833-f828fe617d11a2a87052b2786&q=${q}&page=${currentPage}&per_page=${pageSize}';
    http.get(Uri.parse(url)).then((resp) {
      setState(() {
        dataGallery = json.decode(resp.body);
        hits.addAll(dataGallery['hits']);
        if (dataGallery['totalHits'] % pageSize == 0)
          totalPages = dataGallery['totalHits'] ~/ pageSize;
        else
          totalPages = 1 + (dataGallery['totalHits'] / pageSize).floor();
      });
    }).catchError((err) {
      print(err);
    });
  }

  //render function ---------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${query} => page ${currentPage}/${totalPages}"),
          backgroundColor: Colors.deepOrange,
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
                          hits = [];
                          currentPage = 1;
                          this.query = queryTextEditingController.text;
                          loadData(query);
                        });
                      })
                ],
              ),
              Expanded(
                  child: (ListView.builder(
                      itemCount: (dataGallery == null ? 0 : hits.length),
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      hits[index]['tags'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                color: Colors.deepOrange,
                              ),
                            ),
                            Container(
                              child: Card(
                                child: Image.network(
                                  hits[index]['webformatURL'],
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 10, right: 10),
                            )
                          ],
                        );
                      })))
            ],
          ),
        ));
  }
}
