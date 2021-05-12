import 'dart:math';

import 'package:contact_application/model/contact.model.dart';


class ContactsRepository{
  Map<int,Contact> contacts={
    1:Contact(id:1,name:"hamza",profile:"ha",type: "Student",score:34),
    2:Contact(id:2,name:"Wissal",profile:"Wiss",type: "Developer",score:527),
    3:Contact(id:3,name:"asmae",profile:"asmae",type: "Student",score:457),
    4:Contact(id:4,name:"mouad",profile:"mouad",type: "Developer",score:526),
    5:Contact(id:5,name:"amine",profile:"amine",type: "Student",score:999)
  };

  Future<List<Contact>> allContatcs() async {
    var future = await Future.delayed(Duration(seconds : 1));
    int rnd = new Random().nextInt(10);
    if(rnd>1){ //10% d'avoir des erreurs = Probabilite
      return contacts.values.toList();
    }else{
      throw new Exception("Internet Error");
    }
  }
  Future<List<Contact>> contactsByType(String type) async {
    var future = await Future.delayed(Duration(seconds : 1));
    int rnd = new Random().nextInt(10);
    if(rnd>3){
      return contacts.values.toList().where((element) => element.type == type).toList();
    }else{
      throw new Exception("Internet Error");
    }
  }
}