import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/screens/LoginScreen/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  static final routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _fullname = new TextEditingController();
  final _email = new TextEditingController();
  final _username = new TextEditingController();
  final _phoneNumber = new TextEditingController();
  final _address = new TextEditingController();
  final _password = new TextEditingController();
  final _reenterPassword = new TextEditingController();


  Future<void> register() async {
    if (_fullname.text == '' || _email.text == ''|| _username.text ==''|| _phoneNumber.text =='' || _address.text==''|| _password.text==''||_reenterPassword.text=='' ) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Vui lòng điền đầy đủ thông tin"),
            // content: Text(""),
          )
      );
    } else if(_password.text != _reenterPassword.text){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Mật khẩu không trùng khớp"),
            // content: Text(""),
          )
      );

    }
    else {
      //add the post logic for login here
      Navigator.pushNamed(context, LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              children: [

                SizedBox(height: 10),
                TextFormField(
                  controller: _fullname,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Họ tên',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Họ tên",
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
                  controller: _email,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Email",
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
                    controller: _username,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Username",
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
                    controller: _phoneNumber ,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: 'Số điện thoại',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Số điện thoại",
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
                    controller: _address,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Địa chỉ',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Địa chỉ",
                      alignLabelWithHint: true,
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
                  height: 10.0,
                ),
                TextFormField(
                    controller: _password,
                    autofocus: false,
                    obscureText: true,
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
                SizedBox(height: 10),
                TextFormField(
                    controller: _reenterPassword,
                    autofocus: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Nhập lại mật khẩu',
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Nhập lại mật khẩu",
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
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  // color: Colors.blue,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        TextButton(
                            onPressed: register,
                            child: Text("Đăng ký", style: TextStyle(fontSize: 20.0, color: Colors.white),)
                        ),
                      ]
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
