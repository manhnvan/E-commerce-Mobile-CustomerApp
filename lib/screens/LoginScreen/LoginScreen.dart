import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/abstracts/colors.dart';
import 'package:seller_app/abstracts/variables.dart';
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
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    super.initState();
  }

  var dio = new Dio();

  Future<void> loginUser() async {
    if (_phoneNumber.text == '' || _password.text == '') {
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text("Please fulfill the form"),
                // content: Text(""),
              ));
    } else {
      dio.post('$api_url/seller/login', data: {
        'phone': _phoneNumber.text,
        'password': _password.text
      }).then((value) {
        if (value.data['success']) {
          prefs.setString('sellerId', value.data['_id']);
          prefs.setString('username', value.data['username']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
                (Route<dynamic> route) => false,
          );
        } else {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text(value.data['msg']),
                  ));
        }
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("Error"),
                ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: color_gradient_tertiary
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: space_huge * 2, horizontal: space_medium),
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/images/logo.png'),
                    height: 180,
                  ),
                  SizedBox(height: space_big),

                  //Phone number field here~~~~
                  TextFormField(
                      controller: _phoneNumber,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Số điện thoại',
                        labelText: "Số điện thoại",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              border_radius_big),
                          borderSide:
                          BorderSide(color: color_primary_darker, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              border_radius_big),
                          borderSide: BorderSide(
                            color: color_secondary,
                            width: 1.5,
                          ),
                        ),
                      )),

                  SizedBox(height: space_medium),

                  //Password field here~~~~
                  TextFormField(
                      obscureText: true,
                      controller: _password,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        labelText: "Mật khẩu",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              border_radius_big),
                          borderSide:
                          BorderSide(color: color_primary_darker, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              border_radius_big),
                          borderSide: BorderSide(
                            color: color_secondary,
                            width: 1.5,
                          ),
                        ),
                      )),

                  SizedBox(height: space_medium),

                  //Sign in button here~~~~
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: space_small, horizontal: space_big),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7,
                      decoration: BoxDecoration(
                          gradient: color_gradient_dark,
                          borderRadius: BorderRadius.all(
                              Radius.circular(border_radius_big)),
                          boxShadow: [box_shadow_black]),
                      child: TextButton(
                          onPressed: loginUser,
                          child: Text(
                            "Đăng nhập",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: color_white),
                          )),
                    ),
                  ]),

                  SizedBox(height: space_huge),

                  //Sign up link here~~~~
                  Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text(
                        "Bạn mới biết đến EzShopping?",
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                            "Đăng ký",
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: color_secondary)
                        ))
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//0866770902