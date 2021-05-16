import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seller_app/components/BottomNavBar.dart';
import 'package:image_picker/image_picker.dart';
import '../../constaint.dart';

class AccountScreen extends StatefulWidget {
  static final routeName = '/account';
  AccountScreen({
    Key key,
    this.fullname,
    this.username,
    this.gender,
    this.birthday,
    this.email,
    this.phoneNumber,
    this.address
  }) : super(key: key);

  String fullname, username, gender, birthday, email, phoneNumber, address;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black12,
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.lightBlueAccent
                  ),
                  child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Họ tên", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Lê Thị Thảo", style: TextStyle(fontSize: 17.0),)
                            ),
                          ],
                        ),
                        Divider(
                          height: 4.0,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Tên đăng nhập", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("thaopanda", style: TextStyle(fontSize: 17.0),)
                            ),
                          ],
                        ),
                      ]
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.orangeAccent
                  ),
                  child: Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Giới tính", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Nữ", style: TextStyle(fontSize: 17.0),)
                            ),
                          ],
                        ),
                        Divider(
                          height: 4.0,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Ngày sinh", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("24-07-2000", style: TextStyle(fontSize: 17.0),)
                            ),

                          ],
                        ),
                        Divider(
                          height: 4.0,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Email", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("thaoa4vuive@gmail.com", style: TextStyle(fontSize: 17.0),)
                            ),

                          ],
                        ),
                        Divider(
                          height: 4.0,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Số điện thoại", style: TextStyle(fontSize: 17.0),)
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("0123456789", style: TextStyle(fontSize: 17.0),)
                            ),

                          ],
                        ),
                        Divider(
                          height: 4.0,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                height: 50.0,
                                child: Text("Địa chỉ", style: TextStyle(fontSize: 17.0),)
                            ),
                            Flexible(
                              child: Column(
                                  children:[
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                        height: 50.0,
                                        child: Text("Cao Trung, Đức Giang, Hoài Đức, Hà Nội", style: TextStyle(fontSize: 17.0), overflow: TextOverflow.ellipsis,)
                                    ),
                                  ]
                              ),
                            ),


                          ],
                        ),
                      ]
                  )
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.orangeAccent
                  ),
                  child: TextButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            title: Text("Thay đổi thông tin cá nhân", textAlign: TextAlign.center,),
                            content: Container(
                              height: 400.0,
                              child: SingleChildScrollView(
                                child: Column(
                                  children:[
                                    Container(
                                      height: 350.0,
                                      child: Column(
                                        children: [
                                          TextFormField(
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
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          TextFormField(
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
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          TextFormField(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                hintText: 'Điện thoại',
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Điện thoại",
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
                                          TextFormField(
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
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width:100.0,
                                          child: TextButton(
                                              onPressed: (){},
                                              child: Text("Hủy", style: TextStyle(fontSize: 15.0),)
                                          ),
                                          color: Colors.greenAccent,
                                        ),
                                        Container(
                                          width:100.0,
                                          child: TextButton(
                                              onPressed: (){},
                                              child: Text("Lưu", style: TextStyle(fontSize: 15.0),)
                                          ),
                                          color: Colors.orange,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      );
                    },
                    child: Column(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Thay đổi thông tin cá nhân", style: TextStyle(fontSize: 17.0, color: Colors.black),)
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              )
                            ],
                          ),
                        ]
                    ),
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.orangeAccent
                  ),
                  child: TextButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            title: Text("Thay đổi mật khẩu", textAlign: TextAlign.center,),
                            content: Container(
                              height: 300.0,
                              child: SingleChildScrollView(
                                child: Column(
                                  children:[
                                    Container(
                                      height: 250.0,
                                      // decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.circular(12.0),
                                      //     color: Colors.white
                                      // ),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                hintText: 'Mật khẩu cũ',
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Mật khẩu cũ",
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
                                          TextFormField(
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                hintText: 'Mật khẩu mới',
                                                fillColor: Colors.white,
                                                filled: true,
                                                labelText: "Mật khẩu mới",
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
                                          TextFormField(
                                              autofocus: false,
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
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width:100.0,
                                          child: TextButton(
                                              onPressed: (){},
                                              child: Text("Hủy", style: TextStyle(fontSize: 15.0),)
                                          ),
                                          color: Colors.greenAccent,
                                        ),
                                        Container(
                                          width:100.0,
                                          child: TextButton(
                                              onPressed: (){},
                                              child: Text("Lưu", style: TextStyle(fontSize: 15.0),)
                                          ),
                                          color: Colors.orange,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // actions: <Widget>[
                            //   FlatButton(
                            //     child: Text('Close me!'),
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //   )
                            // ],
                          )
                      );
                    },
                    child: Column(
                        children:[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                  height: 50.0,
                                  child: Text("Thay đổi mật khẩu", style: TextStyle(fontSize: 17.0, color: Colors.black),)
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25,
                              )
                            ],
                          ),
                        ]
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(4),
    );
  }
}
