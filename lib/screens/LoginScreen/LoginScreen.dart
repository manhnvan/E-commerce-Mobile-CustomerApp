import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/screens/HomeScreen/HomeScreen.dart';
import 'package:seller_app/screens/RegisterScreen/RegisterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constaint.dart';


class LoginScreen extends StatefulWidget {
  static final routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _phoneNumber = new TextEditingController();
  final _password = new TextEditingController();

  SharedPreferences prefs;
  
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    super.initState();
  }

  var dio = new Dio();

  Future<void> loginUser() async {
    
    if (_phoneNumber.text == '' || _password.text == '' ) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Please fullfill the form"),
            // content: Text(""),
          )
      );
    } else {
      dio.post('$api_url/seller/login', data: {
        'phone': _phoneNumber.text,
        'password': _password.text
      }).then((value) {
        if (value.data['success']) {
          prefs.setString('sellerId', value.data['_id']);
          prefs.setString('username', value.data['username']);
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,  (Route<dynamic> route) => false,);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(value.data['msg']),
            )
          );
        }
      }).catchError((e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
          )
        );
      });
      
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
                  controller: _phoneNumber,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Số điện thoại',
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Số điệnt thoại",
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
            ],
          ),
        ),
      ),
    );
  }
}
