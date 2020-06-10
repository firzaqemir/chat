import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/chat_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chatapp/login.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  SharedPreferences sharedPreferences;

  Future<void> Chats() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var jsonData = null;
    if (token == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    } else {
      var code = sharedPreferences.getInt('code');
      var response = await http.get(
          Uri.encodeFull(
              "https://eventku.fahmifa.website/api/auth/berandachat?code=$code"),
          headers: {
            'Authorization': "Bearer $token",
          });
      jsonData = jsonDecode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        setState(() {
          peserta = jsonData['peserta'];
          id = jsonData['id']['id'];
          user_id = jsonData['id']['user_id'];
          event_id = jsonData['id']['event_id'];
          admin_event_id = jsonData['id']['admin_event_id'];
          chat = jsonData['id']['chat'];
          created_at = jsonData['id']['created_at'];
          update_at = jsonData['id']['update_at'];
          a = jsonData['a'];
        });
//        print(jsonData);
      } else {
        peserta = '----';
        id = '?';
        user_id = '?';
        event_id = '?';
        admin_event_id = '?';
        chat = '?';
        created_at = '?';
        update_at = '?';
        a = '?';
      }
    }
  }

  var peserta;
  var id;
  var user_id;
  var event_id;
  var admin_event_id;
  var chat;
  var created_at;
  var update_at;
  var a;

  @override
  void initState() {
    super.initState();
    Chats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Chats",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.yellow,
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "New",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.yellow,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey.shade100,
                            )),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: Chats(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot.data);
                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text("Loading..."),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
//                            shrinkWrap: true,
//                            padding: EdgeInsets.only(top: 16),
//                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    maxRadius: 30,
                                  ),
                                  title: Text(snapshot.data.peserta),
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChatDetailPage()),
                                        (Route<dynamic> route) => false);
                                  });
                            },
                          );
                        }
                      })
                ])));
  }
}

//class ChatUsers {
//  String text;
//  String secondaryText;
//  String image;
//  String time;
//
//  ChatUsers({@required this.text,
//    @required this.secondaryText,
//    @required this.image,
//    @required this.time});
//}
//
//class ChatUsersList extends StatefulWidget {
//  String text;
//  String secondaryText;
//  String image;
//  String time;
//  bool isMessageRead;
//
//  ChatUsersList({@required this.text,
//    @required this.secondaryText,
//    @required this.image,
//    @required this.time,
//    @required this.isMessageRead});
//
//  @override
//  _ChatUsersListState createState() => _ChatUsersListState();
//}
//
//class _ChatUsersListState extends State<ChatUsersList> {
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//        onTap: () {
//          Navigator.push(context, MaterialPageRoute(builder: (context) {
//            return ChatDetailPage();
//          }));
//        },
//        child: Container(
//            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
//            child: Row(children: <Widget>[
//              Expanded(
//                child: Row(
//                  children: <Widget>[
//                    CircleAvatar(
//                      backgroundImage: AssetImage(widget.image),
//                      maxRadius: 30,
//                    ),
//                    SizedBox(
//                      width: 16,
//                    ),
//                    Text(
//                      widget.time,
//                      style: TextStyle(
//                          fontSize: 12,
//                          color: widget.isMessageRead
//                              ? Colors.black
//                              : Colors.grey.shade500),
//                    ),
//                  ],
//                ),
//              ),
//            ])));
//  }
//}
