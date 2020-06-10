import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/chat_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  @override
  FormLogin createState() => FormLogin();
}

class FormLogin extends State<Login> {
  @override
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController code = new TextEditingController();
  bool _isLoading = false;
  bool _errorLogin = false;
  var ErrorMsg = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0xff222222),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <
              Widget>[
            Container(
              margin: const EdgeInsets.only(top: 45, bottom: 15),
            ),
            Text(
              "QR-CODE",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "SCANNER",
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 8,
                  fontSize: 25,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              'ACARAKU.COM',
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 8,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 40, //punya yg kuning
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF7DF40),
                  borderRadius: BorderRadius.circular(30)),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.8,
              child:
              Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: 10, right: 10, bottom: 10, left: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: TextField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Color(0xff222222), fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding:
                        EdgeInsets.only(right: 10, bottom: 10, left: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                      color: Color(0xff222222), fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding:
                        EdgeInsets.only(right: 10, bottom: 10, left: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width - 40,
                          child: Material(
                            elevation: 10,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: TextField(
                                controller: code,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "ID Acara",
                                  labelStyle: TextStyle(
                                      color: Color(0xff222222), fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        )),
                    Row(
                      //alignment: Alignment.centerLeft,
                        children: <Widget>[
                          Checkbox(
                            onChanged: (_) {},
                            value: true,
                          ),
                          Expanded(
                              child: Text(
                                "Saya telah membaca Kebijakan Privasi dari Layanan ini",
                                style: TextStyle(),
                              )),
                        ]),
                    SizedBox(
                      height: 0,
                    ),
                    new Container(
                      margin: const EdgeInsets.only(top: 0, bottom: 10),

                      child: Text("$ErrorMsg", style: TextStyle(color: Colors.redAccent, fontSize: 10),),
                    ),
                    new Container(
                      child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          color: Color(0xff222222),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          child: Text(
                            'MASUK',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: email.text == "" || password.text =="" || code.text =="" ?null: () {
                            setState(() {
                              _isLoading = true;
                            });
                            signIn(email.text, password.text, code.text);
                          }),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: 23.0,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 90),
            ),
            ClipPath(
              clipper: OvalTopBorderClipper(),
              child: Container(
                height: 75,
                width: 500,
                color: Color(0xffF7DF40),
                child: Column(children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 0),
                    child: new Text(
                      'by DevT Brain Corp',
                      style: TextStyle(color: Color(0xff222222)),
                    ),
                  ),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }

  signIn(String email, String password, String code) async{
    Map data = {
      'email' : email,
      'password': password,
      'code': code
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData = null;
    var response = await http.post("https://eventku.fahmifa.website/api/auth/login", body: data);
    if(response.statusCode == 200){
      jsonData = jsonDecode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        sharedPreferences.setInt("code", jsonData['code']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ChatPage()), (Route<dynamic> route) => false);
      });
    }else{
      setState(() {
        _isLoading = false;
      });
      print(response.body);
      _errorLogin = true;
    }
    if(_errorLogin==true){
      ErrorMsg = '* Login gagal, Periksa kembali inputan ada.';
    }else{
      ErrorMsg = '';
    }
  }

  Widget roundedRectButton(String title, List<Color> gradient) {
    return Builder(builder: (BuildContext mContext) {
      return InkWell(
        onTap: null,
        splashColor: Color(0xff222222),
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery
              .of(mContext)
              .size
              .height * 0.06,
          width: MediaQuery
              .of(mContext)
              .size
              .width / 2,
          decoration: ShapeDecoration(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          child: Text(title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500)),
        ),
      );
    });
  }
}