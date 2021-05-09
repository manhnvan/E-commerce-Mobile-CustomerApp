import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/screens/RegisterScreen/RegisterScreen.dart';


class LoginScreen extends StatefulWidget {
  static final routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _username = new TextEditingController();
  final _password = new TextEditingController();

  Future<void> loginUser() async {
    if (_username.text == '' || _password.text == '' ) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Vui lòng điền đầy đủ thông tin"),
            // content: Text(""),
          )
      );
    } else {
      //add the post logic for login here
      Navigator.pushNamed(context, HomeScreen.routeName);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 25.0),
          // color: Colors.blue,
          child: Column(
            children: [
              SizedBox(height: 20),
              Image(
                  image: AssetImage('images/logo.png'),
                  height:180 ,
              ),
              SizedBox(height: 20),
              TextFormField(
                  controller: _username,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Tên đăng nhập',
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Tên đăng nhập",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(127, 140, 141,1.0),
                          width: 1.5
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(46, 204, 113,1.0),
                        width: 1.5,
                      ),
                    ),
                  )
              ),

              SizedBox(height: 10),
              TextFormField(
                  obscureText: true,
                  controller: _password,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Mật khẩu',
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Mật khẩu",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(127, 140, 141,1.0),
                          width: 1.5
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(46, 204, 113,1.0),
                        width: 1.5,
                      ),
                    ),
                  )
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      TextButton(
                          onPressed: loginUser,
                          child: Text("Đăng nhập", style: TextStyle(fontSize: 20, color: Colors.white),)
                      ),
                    ]
                ),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Bạn mới biết đến EzShopping?", style: TextStyle(fontSize: 17.0),),
                      TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, RegisterScreen.routeName);
                          },
                          child: Text("Đăng ký", style: TextStyle(fontSize: 17.0),))
                    ]
                ),
              ),
              SizedBox(height: 5,),

              Divider(
                height: 8.0,
                color: Colors.black,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Đăng nhập với", style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black),),
                ],
              ),

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: (){
                      print("ok");
                    },
                    child: Image(
                      image: AssetImage('images/Google-2.png'),
                      height: 55,
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      print("ok");
                    },
                    child: Image(
                      image: AssetImage('images/Facebook-2.png'),
                      height: 55,
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
